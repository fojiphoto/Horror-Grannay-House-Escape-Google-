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

    public bool checker = true;
    private void Awake()
    {
        Instance = this;
        Time.timeScale = 1;
        Application.targetFrameRate = 60;
        AS = GetComponent<AudioSource>();
    }

    private void Start()
    {
        // Levels[PlayerPrefs.GetInt("Level")].SetActive(true);

        
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
                Instruction.ShowDlgBar("You are captured by the Scary Granny! Go, Find the House Map & 3 Keys to find your way out of this Horror Place.");
                Debug.Log("heeeeeeeeeeeeeeeeeeee");
            }
            else if (PlayerPrefs.GetInt("Level") == 1)
            {
                Instruction.ShowDlgBar("Now, you must find the First Spare Key to Enter the First Floor of the house!");


            }
            else if (PlayerPrefs.GetInt("Level") == 2)
            {
                Instruction.ShowDlgBar("You have entered the Main Floor but the Fuse is out. Fix the Electric Fuse in the Kitchen");


            }

            else if (PlayerPrefs.GetInt("Level") == 3)
            {
                Instruction.ShowDlgBar("Now, find the Missing Radio to get some important news from it to get out of here!");


            }
            else if (PlayerPrefs.GetInt("Level") == 4)
            {
                Instruction.ShowDlgBar("Evil Granny has Cursed Spell Books in her Library. Get Lighter from kitchen & burn all her Books!");

                Mobile.SetActive(true);
            }
            else if (PlayerPrefs.GetInt("Level") == 5)
            {
                Instruction.ShowDlgBar("From Radio, you heard that your Uncle is also been captured by Evil Granny. Save your Uncle in the main floor!");


            }
            else if (PlayerPrefs.GetInt("Level") == 6)
            {
                Instruction.ShowDlgBar("There is a Secret Room in the Basement where the Second Key is hidden. Go & Search the Basement!");
                Frame.SetActive(false);


                Mobile.SetActive(true);
            }
            else if (PlayerPrefs.GetInt("Level") == 7)
            {
                Instruction.ShowDlgBar("There is a Secrect Room on top floor washroom's. Granny prisoned your Mom there, save Her now!");


            }
            else if (PlayerPrefs.GetInt("Level") == 8)
            {
                Instruction.ShowDlgBar("The 3rd Key is in the Top left Corner Room. Go & Escape by gathering the Last Key!");


            }

            else if (PlayerPrefs.GetInt("Level") == 9)
            {
                Instruction.ShowDlgBar("Final Act, Evil Granny is Casting a Spell on you. So, you wouldn't Escape even with keys! Burn her!");


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
        PausePanel.SetActive(true);
        // GameObject.FindGameObjectWithTag("Player").GetComponent<CrosshairGUI>().enabled = false;
        Player.GetComponent<CrosshairGUI>().enabled = false;
        Time.timeScale = 0;
        if (PlayerPrefs.GetInt("RemoveAds") == 1)
        {
            Debug.Log("Ads has been Removed.");
        }
        else
        {
            Advertisements.Instance.ShowInterstitial();
        }
    }
    public void OnFail()
    {
        Time.timeScale = 0;
      
        FailPanel.SetActive(true);
        if (PlayerPrefs.GetInt("RemoveAds") == 1)
        {
            Debug.Log("Ads has been Removed.");
        }
        else
        {
            Advertisements.Instance.ShowInterstitial();
        }
        
        //AS.PlayOneShot(LevelFailedSFX);
    }
    public void OnComplete()
    {
        Time.timeScale = 0;
       
        CompletePanel.SetActive(true);
        AS.PlayOneShot(LevelCompleteSFX);
        if (PlayerPrefs.GetInt("RemoveAds") == 1)
        {
            Debug.Log("Ads has been Removed.");
        }
        else
        {
            Advertisements.Instance.ShowInterstitial();
        }
      
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
    }
    public void OnRestart()
    {
        FailPanel.SetActive(false);
        Player.GetComponent<CrosshairGUI>().enabled = true;
        Time.timeScale = 1;
        // Time.timeScale = 1;
        // SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex);
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
