using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.Networking;
using UnityEngine.Events;
using Random = UnityEngine.Random;

namespace HagridsTools
{
    namespace CrossProm
    {
        public class CrossPromStaticData
        {
            public static string PLAYER_PREFS_VALUE = "CrossProm" + Application.version;
            public static string PLAYER_RREFS_UPDATE_VALUE = "CrossPromLastUpdate";
            public static string PLAYER_PREFS_UPDATE_STATUS_VALUE = "CrossPromLastUpdateStatus";
        }

        public class CrossPromController : MonoBehaviour
        {
            public static CrossPromController instance;

            [Tooltip("Checking this will disable whole plugin. Can be useful with NoAds.")]
            public bool m_Disabled = false;

            public bool m_DisableAutoAdShow = false;

            [Tooltip("Checking this will disable updating function. Its useful when you don't have server to host updates.")]
            public bool m_OfflineMode = false;

            [Tooltip("If you decide to use Weight Random System, ads with higher weight will appear more often.")]
            public bool m_WeightedRandom = true;

            [Tooltip("Won't show ads for already installed games.")]
            public bool m_FilterInstalledGames = true;

            public CrossPromOptions m_OptionsAsset;

            [Tooltip("X: Min Value, Y: Max Value in seconds.")]
            public Vector2 m_TimerDurationRange = new Vector2(180f, 300f);

            [Tooltip("How often does CrossProm updates? Value is in days. Leave at 0, if you want it to constantly update data.")]
            [Range(0, 30)]
            public int m_UpdateFrequency = 3;

            [Header("Outputs for canvas")]
            public GameObject m_AdGameObject;
            public Text m_Title;
            public Text m_Description;
            public Image m_Image;
            public Image[] m_ColorableImages;

            internal GameAd m_ChosenAd;
            internal bool m_IsDownloading = false;

            [Header("Time to Update")]

            public int Time = 1000;

            #region Events
            internal UnityAction<GameAd> Event_OnAdShow;
            internal UnityAction<GameAd> Event_OnAdDownload;
            internal UnityAction<GameAd> Event_OnAdQuit;
            #endregion

            private void Awake()
            {
                if (instance != null)
                {
                    Destroy(this.gameObject);
                    return;
                }

                instance = this;
                DontDestroyOnLoad(gameObject);
            }

            private void Start()
            {
                Init();


              //   PlayerPrefs.SetInt("Time", 1);


            }

            private void Update()
            {
                if (PlayerPrefs.GetInt("Time") == 1)
                {
                    Time -= 1;
                    if (Time <= 0)
                    {
                        Time = 1000;
                        m_AdGameObject.SetActive(false);
                        InvokeNewAd();
                    }
                }
            }


            #region Initialization
            private void Init()
            {
                m_OptionsAsset.InitializeCrossPromData();

                if (m_FilterInstalledGames)
                    m_OptionsAsset.FilterInstalledGames();

#if UNITY_EDITOR
                m_OptionsAsset.DeserializeList(m_OptionsAsset.SerializeList(), true);
#endif

                if (!m_Disabled)
                    CheckForUpdates();
            }

            public void DisableCrossProm()
            {
                m_Disabled = true;

                if (IsInvoking("ShowAd"))
                    CancelInvoke("ShowAd");
            }
            #endregion

            #region UI Feedback
            public void OnQuitClick()
            {
                if (Event_OnAdQuit != null)
                    Event_OnAdQuit.Invoke(m_ChosenAd);

                m_AdGameObject.SetActive(false);

                if (!m_DisableAutoAdShow)
                    InvokeNewAd();
            }

            public void OnDownloadClick()
            {
                if (Event_OnAdDownload != null)
                    Event_OnAdDownload.Invoke(m_ChosenAd);

                m_AdGameObject.SetActive(false);

                if (!m_DisableAutoAdShow)
                    InvokeNewAd();

#if UNITY_ANDROID
                Application.OpenURL(m_ChosenAd.m_AndroidUrl);
#endif
#if UNITY_IOS
                Application.OpenURL(m_ChosenAd.m_IOSUrl);
#endif
            }
            #endregion

            #region ShowAd
            public void InvokeNewAd()
            {
                if (!IsInvoking("ShowAd"))
                    Invoke("ShowAd", (int)Random.Range(m_TimerDurationRange.x, m_TimerDurationRange.y));
            }

            public void InvokeNewAd(bool _SkipTimer)
            {
                if (!_SkipTimer)
                {
                    InvokeNewAd();
                    return;
                }

                if (IsInvoking("ShowAd"))
                    CancelInvoke("ShowAd");

                ShowAd();
            }

            private void ShowAd()
            {
                if (m_Disabled || m_OptionsAsset.m_PromoGamesList.Count <= 0 || m_IsDownloading)
                {
                    InvokeNewAd();
                    return;
                }

                GameAd _NewAd = m_OptionsAsset.GetRandomAd(m_WeightedRandom);

                if (_NewAd.m_PackageID == Application.identifier)
                {
                    ShowAd();
                    return;
                }

                if (!m_WeightedRandom)
                {
                    if (m_ChosenAd != null)
                    {
                        if (_NewAd.m_PackageID == m_ChosenAd.m_PackageID && m_OptionsAsset.m_PromoGamesList.Count > 1)
                        {
                            ShowAd();
                            return;
                        }
                    }
                }

                m_ChosenAd = _NewAd;

                if (m_AdGameObject != null)
                     m_AdGameObject.SetActive(true);

                if (m_Title != null)
                    m_Title.text = m_ChosenAd.m_Name;

                if (m_Image != null)
                    m_Image.sprite = m_OptionsAsset.GetImage(m_ChosenAd);

                if (m_Description != null)
                    m_Description.text = m_ChosenAd.m_Descirption;

                ColorUtility.TryParseHtmlString(m_ChosenAd.m_ColorTheme, out Color _New);

                if (m_ColorableImages != null)
                    for (int i = 0; i < m_ColorableImages.Length; i++)
                        m_ColorableImages[i].color = _New;

                if (Event_OnAdShow != null)
                    Event_OnAdShow.Invoke(_NewAd);
            }
            #endregion

        

            #region Utilities
            private void CheckForUpdates()
            {
                if (m_OfflineMode || m_OptionsAsset == null)
                    return;

                if (!IsUpdateTime())
                    return;

                if (Application.internetReachability != NetworkReachability.NotReachable)
                    StartCoroutine("GetDataIE");
            }

            private bool IsUpdateTime()
            {
                if (!PlayerPrefs.HasKey(CrossPromStaticData.PLAYER_RREFS_UPDATE_VALUE))
                    return true;

                if (PlayerPrefs.GetInt(CrossPromStaticData.PLAYER_PREFS_UPDATE_STATUS_VALUE, 0) != 1)
                    return true;

                DateTime _CurrentUTC = DateTime.UtcNow;
                DateTime _LastUTC = DateTime.Parse(PlayerPrefs.GetString(CrossPromStaticData.PLAYER_RREFS_UPDATE_VALUE));
                TimeSpan _TimeDifference = _CurrentUTC - _LastUTC;

                if (_TimeDifference.Days >= m_UpdateFrequency)
                    return true;
                else
                    return false;
            }

            public bool IsThisGameInstalled(GameAd _GameAd)
            {
                if (!m_FilterInstalledGames)
                    return false;

#if UNITY_ANDROID && !UNITY_EDITOR
                AndroidJavaClass _NewUnityPlayer = new AndroidJavaClass("com.unity3d.player.UnityPlayer");
                AndroidJavaObject _CurActivity = _NewUnityPlayer.GetStatic<AndroidJavaObject>("currentActivity");
                AndroidJavaObject _PackageManager = _CurActivity.Call<AndroidJavaObject>("getPackageManager");
                AndroidJavaObject _LaunchIntent = null;

                try
                {
                    _LaunchIntent = _PackageManager.Call<AndroidJavaObject>("getLaunchIntentForPackage", _GameAd.m_PackageID);
                }
                catch (Exception e)
                {
                    Debug.Log("Exception " + e.Message);
                }

                if (_LaunchIntent == null)
                    return false;

                return true;
#elif UNITY_IOS && UNITY_EDITOR
                return false;
#else
                return false;
#endif
            }
            #endregion

            #region DOWNLOADER
            int _DownloadSuccess = 0;

            IEnumerator GetDataIE()
            {
                m_IsDownloading = true;
                _DownloadSuccess = 0;

                UnityWebRequest www = UnityWebRequest.Get(m_OptionsAsset.m_UpdateURL);
                yield return www.SendWebRequest();

                if (string.IsNullOrEmpty(www.error))
                {
                    _DownloadSuccess = 1;
                    m_OptionsAsset.DeserializeList(www.downloadHandler.text, true);
                    StartCoroutine("UpdateImagesIE");
                }

                PlayerPrefs.SetString(CrossPromStaticData.PLAYER_RREFS_UPDATE_VALUE, DateTime.UtcNow.ToString());
                PlayerPrefs.SetInt(CrossPromStaticData.PLAYER_PREFS_UPDATE_STATUS_VALUE, _DownloadSuccess);

                www.Dispose();
                m_IsDownloading = false;
            }

            IEnumerator UpdateImagesIE()
            {
                m_IsDownloading = true;
                _DownloadSuccess = 0;

                for (int i = 0; i < m_OptionsAsset.m_PromoGamesList.Count; i++)
                {
                    for (int b = 0; b < m_OptionsAsset.m_PromoGamesList[i].m_ImageUrls.Length; b++)
                    {
                        if (string.IsNullOrEmpty(m_OptionsAsset.m_PromoGamesList[i].m_ImageUrls[b]))
                            continue;

                        UnityWebRequest www = UnityWebRequestTexture.GetTexture(m_OptionsAsset.m_PromoGamesList[i].m_ImageUrls[b], false);
                        yield return www.SendWebRequest();

                        if (string.IsNullOrEmpty(www.error))
                        {
                            Texture2D _Texture = new Texture2D(2, 2, TextureFormat.RGB24, false);
                            _Texture = DownloadHandlerTexture.GetContent(www);
                            m_OptionsAsset.SetImagePath(m_OptionsAsset.m_PromoGamesList[i].m_Name, _Texture, b);
                            _DownloadSuccess = 1;
                        }
                        else
                            _DownloadSuccess = 0;

                        PlayerPrefs.SetInt(CrossPromStaticData.PLAYER_PREFS_UPDATE_STATUS_VALUE, _DownloadSuccess);

                        www.Dispose();
                    }
                }

                m_IsDownloading = false;
            }
            #endregion
        }
    }
}