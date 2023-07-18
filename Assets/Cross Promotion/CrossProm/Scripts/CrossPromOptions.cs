using System.IO;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.Networking;
using Newtonsoft.Json;

#if UNITY_EDITOR
using UnityEditor;
#endif

namespace HagridsTools
{
    namespace CrossProm
    {
        [System.Serializable]
        public class AdWeight
        {
            public float m_ChanceWeight;

            internal float m_ChancePercent;
            internal float m_ChanceRangeFrom;
            internal float m_ChanceRangeTo;
        }

        [System.Serializable]
        public class GameAd
        {
            public string m_Name;
            public string m_Descirption;
            public string m_AndroidUrl;
            public string m_IOSUrl;
            public string m_PackageID;
            public string[] m_ImageUrls;
            public AdWeight m_Probability;
            public string m_ColorTheme;
        }

        [CreateAssetMenu(fileName = "CrossProm Configuration", menuName = "CrossProm Options")]
        public class CrossPromOptions : ScriptableObject
        {
            [Tooltip("If you don't have server, leave Update URL blank, and turn on OfflineMode at CrossPromController")]
            public string m_UpdateURL;
            public List<GameAd> m_PromoGamesList = new List<GameAd>();

            internal string m_ExportPath = "";
            internal bool m_IsDownloading = false;

            #region Initialization
            public void InitializeCrossPromData()
            {
                if (!PlayerPrefs.HasKey(CrossPromStaticData.PLAYER_PREFS_VALUE))
                {
                    for (int i = 0; i < m_PromoGamesList.Count; i++)
                    {
                        Texture2D _Texture = Resources.Load<Texture2D>(m_PromoGamesList[i].m_Name);

                        if (_Texture == null)
                            return;

                        File.WriteAllBytes(Application.persistentDataPath + "/" + m_PromoGamesList[i].m_Name + "0.png", _Texture.EncodeToPNG());
                    }

                    return;
                }

#if !UNITY_EDITOR
                DeserializeList(PlayerPrefs.GetString(CrossPromStaticData.PLAYER_PREFS_VALUE), false);
#endif
            }

            public string SerializeList()
            {
                if (m_PromoGamesList == null)
                    m_PromoGamesList = new List<GameAd>();

                string _Temp = JsonConvert.SerializeObject(m_PromoGamesList);
                return _Temp;
            }

            public void DeserializeList(string _Data, bool _Save)
            {
                m_PromoGamesList = new List<GameAd>();
                m_PromoGamesList = JsonConvert.DeserializeObject<List<GameAd>>(_Data);

                if (_Save)
                    SaveToPlayerPrefs(_Data);
            }
            #endregion

            #region Utilities
            public void FilterInstalledGames()
            {
#if UNITY_ANDROID
                foreach (GameAd _GameAd in m_PromoGamesList)
                {
                    if (CrossPromController.instance != null)
                    {
                        if (CrossPromController.instance.IsThisGameInstalled(_GameAd))
                            _GameAd.m_Probability.m_ChanceWeight = 0f;
                    }
                }
#endif
            }

            public GameAd GetRandomAd(bool _UseWeight)
            {
                if (_UseWeight)
                {
                    float probabilityTotalWeight = 0;

                    if (m_PromoGamesList != null && m_PromoGamesList.Count > 0)
                    {
                        float currentProbabilityWeightMaximum = 0f;

                        foreach (GameAd _GameAd in m_PromoGamesList)
                        {
                            if (_GameAd.m_Probability.m_ChanceWeight < 0f)
                            {
                                Debug.Log("You can't have negative weight on an item. Reseting item's weight to 0.");
                                _GameAd.m_Probability.m_ChanceWeight = 0f;
                            }
                            else
                            {
                                _GameAd.m_Probability.m_ChanceRangeFrom = currentProbabilityWeightMaximum;
                                currentProbabilityWeightMaximum += _GameAd.m_Probability.m_ChanceWeight;
                                _GameAd.m_Probability.m_ChanceRangeTo = currentProbabilityWeightMaximum;
                            }
                        }

                        probabilityTotalWeight = currentProbabilityWeightMaximum;

                        foreach (GameAd _GameAd in m_PromoGamesList)
                            _GameAd.m_Probability.m_ChancePercent = ((_GameAd.m_Probability.m_ChanceWeight) / probabilityTotalWeight) * 100;
                    }

                    float pickedNumber = Random.Range(0, probabilityTotalWeight);

                    foreach (GameAd _GameAd in m_PromoGamesList)
                    {
                        if (pickedNumber > _GameAd.m_Probability.m_ChanceRangeFrom && pickedNumber < _GameAd.m_Probability.m_ChanceRangeTo)
                        {
                            int indx = m_PromoGamesList.IndexOf(_GameAd);
                            return m_PromoGamesList[indx];
                        }
                    }

                    Debug.LogError("Item couldn't be picked... Be sure that you have at least one Promo Game");
                    return m_PromoGamesList[0];
                }
                else
                    return m_PromoGamesList[Random.Range(0, m_PromoGamesList.Count)];
            }

            public Sprite GetImage(GameAd _GameAd)
            {
                int _ImageID = GetImageID(_GameAd);

                if (DoesImageExists(_GameAd.m_Name, _ImageID))
                {
                    Texture2D _Texture = new Texture2D(2, 2);
                    byte[] _TargetBytes = File.ReadAllBytes(GetImagePath(_GameAd.m_Name, _ImageID));
                    _Texture.LoadImage(_TargetBytes);
                    return Sprite.Create(_Texture, new Rect(0.0f, 0.0f, _Texture.width, _Texture.height), new Vector2(0.5f, 0.5f));
                }
                else
                    return null;
            }

            public int GetImageID(GameAd _GameAd)
            {
                List<int> _AvailableIDs = new List<int>();

                for (int i = 0; i < _GameAd.m_ImageUrls.Length; i++)
                {
                    if (DoesImageExists(_GameAd.m_Name, i))
                        _AvailableIDs.Add(i);
                }

                return _AvailableIDs[Random.Range(0, _AvailableIDs.Count)];
            }

            public void ExportJSON()
            {
                string _Data = SerializeList();
                File.WriteAllText(m_ExportPath + "/CrossProm.json", _Data, System.Text.Encoding.ASCII);
                Debug.Log("Data has been exported");
            }

            public void SetImagePath(string _Name, Texture2D _Texture, int _ImageID)
            {
                File.WriteAllBytes(GetImagePath(_Name, _ImageID), _Texture.EncodeToPNG());
            }

            public bool DoesImageExists(string _Name, int _ImageID)
            {
                return File.Exists(GetImagePath(_Name, _ImageID));
            }

            private string GetImagePath(string _Name, int _ImageID)
            {
                return Application.persistentDataPath + "/" + _Name + _ImageID.ToString() + ".png";
            }

            private void ExportImage(Texture2D _Texture, int _ImageID)
            {
                File.WriteAllBytes(m_ExportPath + "/" + m_PromoGamesList[downloadID].m_Name + _ImageID.ToString() + ".png", _Texture.EncodeToPNG());
            }

            private void SaveToPlayerPrefs(string _Data)
            {
                PlayerPrefs.SetString(CrossPromStaticData.PLAYER_PREFS_VALUE, _Data);
#if UNITY_EDITOR
                AssetDatabase.SaveAssets();
#endif
            }
            #endregion

            #region CUSTOM_DOWNLOADER

            private UnityWebRequest www;
            internal int downloadID = 0;
            internal int imageCount = 0;

#if UNITY_EDITOR
            public void StartDownloadCycle()
            {
                if (m_IsDownloading)
                    return;

                m_IsDownloading = true;
                www = UnityWebRequest.Get(m_UpdateURL);
                www.SendWebRequest();
                EditorApplication.update += CheckDownload;
            }

            public void StartImageDownload()
            {
                if (m_IsDownloading)
                    return;

                Debug.Log(downloadID + " | " + imageCount);

                if (string.IsNullOrEmpty(m_PromoGamesList[downloadID].m_ImageUrls[imageCount]))
                {
                    if (m_PromoGamesList.Count > downloadID + 1)
                    {
                        Debug.Log("Skipping... Image URL not found on game - " + m_PromoGamesList[downloadID].m_Name);
                        downloadID += 1;
                        StopDownloadCycle();
                        StartImageDownload();
                        return;
                    }
                    else
                    {
                        Debug.Log("Images have been succesfully fetched");
                        StopDownloadCycle();
                        return;
                    }
                }

                m_IsDownloading = true;
                www = UnityWebRequestTexture.GetTexture(m_PromoGamesList[downloadID].m_ImageUrls[imageCount], false);
                www.SendWebRequest();
                EditorApplication.update += CheckImageDownload;
            }

            private void CheckDownload()
            {
                if (www.isDone)
                {
                    if (www.error == null)
                    {
                        DeserializeList(www.downloadHandler.text, true);
                        Debug.Log("Data has been imported");
                    }

                    StopDownloadCycle();
                }
            }

            private void CheckImageDownload()
            {
                if (www.isDone)
                {
                    if (www.error == null)
                    {
                        Texture2D _Texture = new Texture2D(2, 2, TextureFormat.RGB24, false);
                        _Texture = DownloadHandlerTexture.GetContent(www);
                        ExportImage(_Texture, imageCount);

                        if (m_PromoGamesList[downloadID].m_ImageUrls.Length > imageCount + 1)
                        {
                            imageCount += 1;
                            StopDownloadCycle();
                            StartImageDownload();
                            return;
                        }

                        if (m_PromoGamesList.Count > downloadID + 1)
                        {
                            downloadID += 1;
                            imageCount = 0;
                            StopDownloadCycle();
                            StartImageDownload();
                        }
                        else
                        {
                            downloadID = 0;
                            imageCount = 0;
                            StopDownloadCycle();
                            Debug.Log("Images have been succesfully fetched");
                        }
                    }
                    else
                    {
                        Debug.Log("Trying again... Error while fetching images " + www.error);
                        StopDownloadCycle();
                        StartImageDownload();
                    }
                }
            }

            private void StopDownloadCycle()
            {
                m_IsDownloading = false;

                EditorApplication.update -= CheckDownload;
                EditorApplication.update -= CheckImageDownload;

                if (www != null)
                    www.Dispose();
            }
#endif

            #endregion
        }


#if UNITY_EDITOR
        [CustomEditor(typeof(CrossPromOptions))]
        public class AssetEditor : Editor
        {
            [MenuItem("Hagrid's Tools/CrossProm/Documentation")]
            public static void OpenDocumentation()
            {
                if (Application.internetReachability != NetworkReachability.NotReachable)
                    Application.OpenURL("https://docs.wildskullgames.com/CrossProm.html");
                else
                    Application.OpenURL(Application.dataPath + "/Hagrid's Tools/CrossProm/Documentation.html");
            }

            public override void OnInspectorGUI()
            {
                DrawDefaultInspector();

                CrossPromOptions _Script = (CrossPromOptions)target;

                GUILayout.Space(25);

                if (_Script.m_PromoGamesList.Count > 0)
                {
                    if (GUILayout.Button("Export data"))
                    {
                        _Script.m_ExportPath = EditorUtility.SaveFolderPanel("Where to export data?", "", "");

                        if (_Script.m_ExportPath.Length < 3)
                            return;

                        if (!Directory.Exists(_Script.m_ExportPath))
                        {
                            Debug.LogError("Invalid path was provided");
                            return;
                        }

                        _Script.ExportJSON();
                    }
                }

                if (!string.IsNullOrEmpty(_Script.m_UpdateURL) && !_Script.m_IsDownloading)
                {
                    if (GUILayout.Button("Fetch data from network"))
                    {
                        _Script.StartDownloadCycle();
                        Debug.Log("Fetching data");
                    }
                }

                if (GUILayout.Button("Fetch data from local JSON"))
                {
                    string _Path = EditorUtility.OpenFilePanel("Choose your JSON file", "", "");

                    if (string.IsNullOrEmpty(_Path) || _Path.Length < 10)
                        return;

                    string _Data = File.ReadAllText(_Path);

                    _Script.DeserializeList(_Data, true);
                    Debug.Log("Data has been imported");
                }

                if (_Script.m_PromoGamesList.Count > 0 && !_Script.m_IsDownloading)
                {
                    if (GUILayout.Button("Fetch Images"))
                    {
                        _Script.m_ExportPath = EditorUtility.SaveFolderPanel("Where to download images?", "", "");

                        if (_Script.m_ExportPath.Length < 3)
                            return;

                        if (!Directory.Exists(_Script.m_ExportPath))
                        {
                            Debug.LogError("Invalid path was provided");
                            return;
                        }

                        Debug.Log("Fetching Images");
                        _Script.downloadID = 0;
                        _Script.StartImageDownload();
                    }
                }

                if (_Script.m_PromoGamesList.Count > 0)
                {
                    if (GUILayout.Button("Log probability chances"))
                    {
                        _Script.GetRandomAd(true);

                        for (int i = 0; i < _Script.m_PromoGamesList.Count; i++)
                        {
                            Debug.Log(_Script.m_PromoGamesList[i].m_Name + " - " + _Script.m_PromoGamesList[i].m_Probability.m_ChancePercent + "%");
                        }
                    }
                }
            }
        }
#endif
    }
}