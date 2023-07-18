using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class TimeBar : MonoBehaviour
{
    public Image timeBar;

    public float maxTime;
    float timeLeft;

    public GameObject TimeUptext;
  

    // Start is called before the first frame update
    void Start()
    {
        TimeUptext.SetActive(false);
        if (PlayerPrefs.GetInt("Level") == 0)
        {
            maxTime = 180;
        }
        else if (PlayerPrefs.GetInt("Level") == 1)
        {
            maxTime = 240;
        }
        else if (PlayerPrefs.GetInt("Level") == 2)
        {
            maxTime = 300;
        }
        else if (PlayerPrefs.GetInt("Level") == 3)
        {
            maxTime = 300;
        }
        else if (PlayerPrefs.GetInt("Level") == 4)
        {
            maxTime = 360;
        }
        else if (PlayerPrefs.GetInt("Level") == 5)
        {
            maxTime = 420;
        }
        else if (PlayerPrefs.GetInt("Level") == 6)
        {
            maxTime = 300;
        }
        else if (PlayerPrefs.GetInt("Level") == 7)
        {
            maxTime = 80;
        }
        else if (PlayerPrefs.GetInt("Level") == 8)
        {
            maxTime = 300;
        }
        else if (PlayerPrefs.GetInt("Level") == 9)
        {
            maxTime = 300;
        }
        timeLeft = maxTime;
    }

    // Update is called once per frame
    void Update()
    {
        if(timeLeft>0)
        {
            timeLeft -= Time.deltaTime;
            timeBar.fillAmount = timeLeft / maxTime;
        }
        else
        {
            TimeUptext.SetActive(true);
            GamePlayUI.Instance.OnFail();
            GameObject.FindGameObjectWithTag("Player").GetComponent<CrosshairGUI>().enabled = false;
        }
    }
}
