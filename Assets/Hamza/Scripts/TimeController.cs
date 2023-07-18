using UnityEngine;
using System.Collections;
using UnityEngine.UI;
using System;

public class TimeController : MonoBehaviour
{


	public Text timecounterText,TimeUptext;
	public int[] timeToCompleteLevels;
	private float timeToCompleteLevel;

	int remainder;

	public GameObject LevelFailPanel;



	void Start ()
	{
		remainder = PlayerPrefs.GetInt ("Level") % 10 ;



		timeToCompleteLevel = timeToCompleteLevels [remainder];

	}

	void Update ()
	{


		int Minutes = 0;
		int Seconds = 0;
		Minutes = (int)Math.Abs(timeToCompleteLevel / 60);
		Seconds = (int)timeToCompleteLevel % 60;

		if (timeToCompleteLevel >= 0 )
		{
			timeToCompleteLevel -= Time.deltaTime;

		}


		if (timeToCompleteLevel < 5.0F )
		{
			
			TimeUptext.enabled = true;
			TimeUptext.text="Time's Up You Are Late ";

		}

		if (timeToCompleteLevel < 0.0F )
		{

			LevelFailPanel.SetActive(true);
            Time.timeScale = 0;
            //AdScript.adScript.ShowAdLevelFailORExitORLoading();

		}


		timecounterText.text = "0" + Minutes.ToString() + ":";

		if (Seconds < 10)
		{

			timecounterText.text = timecounterText.text + "0" + Seconds.ToString();

		}
		else
		{
			timecounterText.text = timecounterText.text + Seconds.ToString();
		}


	}


}
