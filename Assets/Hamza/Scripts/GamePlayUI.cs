using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class GamePlayUI : MonoBehaviour
{

    public static GamePlayUI Instance;

    public GameObject[] Levels;

    public GameObject Player, grannyai;
    public GameObject PlayerControls;
    public GameObject PausePanel;
    public GameObject FailPanel;
    public GameObject CompletePanel;

    public GameObject Mobile;    //Level5

    public GameObject InstructionPanel;

    public GameObject Frame;

    public Dialough Instruction;

    public AudioSource AS;

    public AudioClip LevelCompleteSFX;
    public AudioClip LevelFailedSFX;
    public GameObject Level1cutscene;
    public bool checker = true;
    private void Awake()
    {
        PlayerPrefs.GetInt("Level");
        Debug.Log("Level number is "+ PlayerPrefs.GetInt("Level"));
        Instance = this;
        Time.timeScale = 1;
        Application.targetFrameRate = 60;
        AS = GetComponent<AudioSource>();
       
    }

    private void Start()
    {
        //Player.transform.position = SpawnManager.Instance.pos.transform.position;
        //SpawnManager.Instance.LoadPos();
        // Levels[PlayerPrefs.GetInt("Level")].SetActive(true);
        if (PlayerPrefs.GetInt("Level") == 0)
        {
            Level1cutscene.SetActive(true);
        }
        OnPlay();
          //  
          //  PlayerControls.SetActive(true);

        //ConsoliAds.Instance.LoadRewarded(3);

    }
    
    private void Update()
    {

        if (checker)
        {
            if (PlayerPrefs.GetInt("Level") == 0)
            {
                

                Instruction.ShowDlgBar("find the Letter");
                //SpawnManager.Instance.SavedPostion();

            }
            else if (PlayerPrefs.GetInt("Level") == 1)
            {
                Instruction.ShowDlgBar(" Find Cutter to Break the Chain ");
                //SpawnManager.Instance.SavedPostion();


            }
            else if (PlayerPrefs.GetInt("Level") == 2)
            {
                Instruction.ShowDlgBar("Confuse he Grimsy switch on the Juicer in the kitchen");
                //SpawnManager.Instance.SavedPostion();

            }

            else if (PlayerPrefs.GetInt("Level") == 3)
            {
                Instruction.ShowDlgBar("find the Phone  Call for Help!!");
                //SpawnManager.Instance.SavedPostion();

            }
            else if (PlayerPrefs.GetInt("Level") == 4)
            {
                Instruction.ShowDlgBar("complete the puzzel placed in the kitchen");
                //SpawnManager.Instance.SavedPostion();
                Mobile.SetActive(true);
            }
            else if (PlayerPrefs.GetInt("Level") == 5)
            {
                Instruction.ShowDlgBar("Get the hammer from the main floor ");
                //SpawnManager.Instance.SavedPostion();

            }
            else if (PlayerPrefs.GetInt("Level") == 6)
            {
                Instruction.ShowDlgBar("Go into the sceret room find a baseball bat");
                Frame.SetActive(false);
                //SpawnManager.Instance.SavedPostion();

                Mobile.SetActive(true);
            }
            else if (PlayerPrefs.GetInt("Level") == 7)
            {
                Instruction.ShowDlgBar("Break the electric board in the bathroom");
                //SpawnManager.Instance.SavedPostion();

            }
            else if (PlayerPrefs.GetInt("Level") == 8)
            {
                Instruction.ShowDlgBar("The escape Key is in the Top Floor Room");
                //SpawnManager.Instance.SavedPostion();

            }

            else if (PlayerPrefs.GetInt("Level") == 9)
            {
                Instruction.ShowDlgBar("go to library room and run away");


            }

            if (PlayerPrefs.GetInt("Level") == 9)
                grannyai.SetActive(false);
            else
                grannyai.SetActive(true);
            

                checker = false;

        }


    }


    public void OnPlay()
    {
        Player.SetActive(true);
        PlayerControls.SetActive(true);
        if (PlayerPrefs.GetInt("Revived")>0)
        {
            PlayerPrefs.SetInt("Level", PlayerPrefs.GetInt("Level"));
        }
        else
        {
            PlayerPrefs.SetInt("Level", 0);
        }
        
         //   this.GetComponent<TimeBar>().enabled = true;
        Time.timeScale = 1f;

            InstructionPanel.SetActive(false);
        Player.GetComponent<CrosshairGUI>().enabled = true;
          //  GameObject.FindGameObjectWithTag("Player").GetComponent<CrosshairGUI>().enabled = true;
            Levels[PlayerPrefs.GetInt("Level")].SetActive(true);


    }

    public void play1()
    {
        Player.SetActive(false);
        PlayerControls.SetActive(false);
        this.GetComponent<TimeBar>().enabled = false;
        InstructionPanel.SetActive(true);
        Time.timeScale = 0f;
    }






    public void OnPause()
    {
        //nadeem
        CASAds.instance.ShowInterstitial();
        //AdsManager.instance?.ShowInterstitialWithoutConditions();
        PausePanel.SetActive(true);
        // GameObject.FindGameObjectWithTag("Player").GetComponent<CrosshairGUI>().enabled = false;
        Player.GetComponent<CrosshairGUI>().enabled = false;
        Time.timeScale = 0;
        //if (PlayerPrefs.GetInt("RemoveAds") == 1)
        //{
        //    Debug.Log("Ads has been Removed.");
        //}
        //else
        //{
        //    Advertisements.Instance.ShowInterstitial();
        //}
    }
    public void OnFail()
    {
        //nadeem
        CASAds.instance.ShowInterstitial();
        //AdsManager.instance?.ShowInterstitialWithoutConditions();


        FailPanel.SetActive(true);
       
    }
    public void OnComplete()
    {
        
       
        CompletePanel.SetActive(true);
        AS.PlayOneShot(LevelCompleteSFX);
      
      
    }


    public void OnResume()
    {
        PausePanel.SetActive(false);
        Player.GetComponent<CrosshairGUI>().enabled = true;
        // GameObject.FindGameObjectWithTag("Player").GetComponent<CrosshairGUI>().enabled = true;
        Time.timeScale = 1;
    }
    public void OnHome()
    {
        SceneManager.LoadScene("GUI");
        PlayerPrefs.SetInt("Revived", 0);
    }

    public void OnRevive()
    {
        CASAds.instance.ShowRewarded(() =>
        {
            Time.timeScale = 1;
            PlayerPrefs.SetInt("Level", PlayerPrefs.GetInt("Level"));
            PlayerPrefs.SetInt("Revived", 1);
            SceneManager.LoadScene("GamePlay");
        });

        //CASAds.instance.ShowRewarded(OnRevivee);

        Debug.Log("Revived Clicked");
        
       
    }
    public void OnRevivee()
    {

        //SpawnManager.Instance.CloseFPS();

        //yield return new WaitForSeconds(1);
        //SpawnManager.Instance.LoadPos();
        //yield return new WaitForSeconds(1);
        //SpawnManager.Instance.StartFPS();
        Time.timeScale = 1;
        PlayerPrefs.SetInt("Level", PlayerPrefs.GetInt("Level"));
        PlayerPrefs.SetInt("Revived", 1);
        SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex);
        //SceneManager.LoadScene(3);
    }
    public void OnRestart()
    {
        
        Time.timeScale = 1;
        PlayerPrefs.SetInt("Level", 0);
        PlayerPrefs.SetInt("Revived", 0);
        SceneManager.LoadScene("GamePlay");
        
    }

    public void levelincrement() {

        if (PlayerPrefs.GetInt("Level") <= 8)
        {
            PlayerPrefs.SetInt("Level", PlayerPrefs.GetInt("Level") + 1);
            checker = true;
            for (int i = 0; i < Levels.Length; i++)
            {
                Levels[i].SetActive(false);
            }
            Levels[PlayerPrefs.GetInt("Level")].SetActive(true);
        }
        else {

            Time.timeScale = 0;
            OnHome();
        }
        PlayerPrefs.SetInt("Revived", 0);
    }
    private void OnApplicationQuit()
    {
        PlayerPrefs.SetInt("Revived", 0);
    }
    public void OnNext()
    {
        if (PlayerPrefs.GetInt("Level") <= 8)
        {
            PlayerPrefs.SetInt("Level", PlayerPrefs.GetInt("Level") + 1);

            if(PlayerPrefs.GetInt("Level") > PlayerPrefs.GetInt("unlock"))
            {
                PlayerPrefs.SetInt("unlock", PlayerPrefs.GetInt("unlock") + 1);
            }

            SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex);
        }
        else
        {
            SceneManager.LoadScene("GUI");
        }
    }
}
