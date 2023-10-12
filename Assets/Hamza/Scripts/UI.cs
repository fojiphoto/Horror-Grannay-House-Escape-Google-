using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class UI : MonoBehaviour
{
    //public GameObject PrivacyPanel;
    public GameObject MainMenu;
    public GameObject ExitPanel;
    public GameObject LevelSelection;
    public GameObject Loading, continuebtn, newgamebtn;
    public GameObject ComingSoon;
    public GameObject RemoveAds;

    public Slider loadingSlider;

    public Text loadingText;

    public GameObject[] LevelLocks;

    public AudioSource AS;

    public AudioClip Click;

    public GameObject MainMenuSFX;

    

    private void Awake()
    {
        Application.targetFrameRate = 60;
    }


    private void Start()
    {
        //PlayerPrefs.SetInt("unlock", 9);

      
        Time.timeScale = 1;

        //Advertisements.Instance.Initialize();

        AS = GetComponent<AudioSource>();
        if (PlayerPrefs.GetInt("Level") <= 0)
        {
            PlayerPrefs.SetInt("Level", 0);
        }
        if (PlayerPrefs.GetInt("Level") > 9)
        {
            PlayerPrefs.SetInt("Level", 9);
        }

        if (PlayerPrefs.GetInt("Level") == 0)
        {
            newgamebtn.SetActive(true);
            continuebtn.SetActive(false);
        }
        else {

            newgamebtn.SetActive(true);
            continuebtn.SetActive(true);
        }

        Debug.Log("Selected Level is " + PlayerPrefs.GetInt("Level"));

        for (int i = 0; i < PlayerPrefs.GetInt("unlock") + 1; i++)
        {
            LevelLocks[i].SetActive(false);
        }

        if (PlayerPrefs.GetInt("PP") == 1)
        {
            //PrivacyPanel.SetActive(false);
            MainMenuSFX.SetActive(true);
            MainMenu.SetActive(true);
            //if (PlayerPrefs.GetInt("RemoveAds") == 1)
            //{
            //    Debug.Log("Ads has been Removed.");
            //}
            //else
            //{
            //    Advertisements.Instance.ShowBanner(BannerPosition.TOP);
            //}
        }



        if (PlayerPrefs.GetInt("RemoveAds") == 1)
        {
            RemoveAds.SetActive(false);
        }
       
    }

   

    public void OnAccept()
    {
        AS.PlayOneShot(Click);
       // PrivacyPanel.SetActive(false);
        PlayerPrefs.SetInt("PP",1);
        MainMenuSFX.SetActive(true);
        MainMenu.SetActive(true);
        //Advertisements.Instance.ShowBanner(BannerPosition.TOP);
    }


    public void OnPlay()
    {
        AS.PlayOneShot(Click);
        MainMenu.SetActive(false);
        LevelSelection.SetActive(true);
    }
    public void OnPrivacy()
    {
        AS.PlayOneShot(Click);
        Application.OpenURL("https://cbgprivacypolicy.blogspot.com/2023/02/privacy-policy.html");
    }
    public void OnMoreGames()
    {
        AS.PlayOneShot(Click);
       Application.OpenURL("https://play.google.com/store/apps/developer?id=CrossBox+Games");
    }
    public void OnRateUs()
    {
        AS.PlayOneShot(Click);
        Application.OpenURL("https://play.google.com/store/apps/details?id=com.codexlayer.horror.scary.granny.house.escape");
    }
    public void OnExit()
    {
        AS.PlayOneShot(Click);
        ExitPanel.SetActive(true);
        MainMenu.SetActive(false);
        //if (PlayerPrefs.GetInt("RemoveAds") == 1)
        //{
        //    Debug.Log("Ads has been Removed.");
        //}
        //else
        //{
        //    Advertisements.Instance.ShowInterstitial();
        //}
       
    }
    public void OnYes()
    {
        AS.PlayOneShot(Click);
        Application.Quit();
    }
    public void OnNo()
    {
        AS.PlayOneShot(Click);
        MainMenu.SetActive(true);
        ExitPanel.SetActive(false);
    }
    public void OnLevelSelectBack()
    {
        AS.PlayOneShot(Click);
        LevelSelection.SetActive(false);
        MainMenu.SetActive(true);
    }


    public void OnSelectLevel(int x)
    {
        AS.PlayOneShot(Click);
        PlayerPrefs.SetInt("life", 5);
        PlayerPrefs.SetInt("Level", x);
        PlayerPrefs.SetInt("map", 0);
        PlayerPrefs.SetInt("light", 0);
        PlayerPrefs.SetInt("maindoorunlock", 0);
        Loading.SetActive(true);
        StartCoroutine(LoadScene());
        //if (PlayerPrefs.GetInt("RemoveAds") == 1)
        //{
        //    Debug.Log("Ads has been Removed.");
        //}
        //else
        //{
        //    Advertisements.Instance.ShowInterstitial();
        //    Advertisements.Instance.HideBanner();
        //}
       
    }

    public void OnContinue()
    {
        AS.PlayOneShot(Click);
       // PlayerPrefs.SetInt("Level", x);
        Loading.SetActive(true);
        StartCoroutine(LoadScene());
        //if (PlayerPrefs.GetInt("RemoveAds") == 1)
        //{
        //    Debug.Log("Ads has been Removed.");
        //}
        //else
        //{
        //    Advertisements.Instance.ShowInterstitial();
        //    Advertisements.Instance.HideBanner();
        //}

    }




  
    IEnumerator LoadScene()
    {
        yield return null;

        
        AsyncOperation asyncOperation = SceneManager.LoadSceneAsync("GamePlay");
   
        asyncOperation.allowSceneActivation = false;
       
       
        while (!asyncOperation.isDone)
        {
            
            loadingSlider.value = loadingSlider.value + 0.1f * Time.deltaTime * 2;
            string percent = (loadingSlider.value * 100).ToString("F0");
            loadingText.text = string.Format("<size=35>{0}%</size>", percent);
           
            if (asyncOperation.progress >= 0.9f && loadingSlider.value == 1f)
            {
                
                asyncOperation.allowSceneActivation = true;
            }

            yield return null;
        }
    }


   

}
