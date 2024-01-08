using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class adsmanager : MonoBehaviour
{
    public TMP_Text textPrompt; // Reference to the TextMeshPro UI element
    public float time = 0;
    private bool promptActive = false;
    public GameObject failpannel;

    private void Update()
    {
        time += Time.deltaTime;
        int timeAsInt = (int)time;
        if (timeAsInt >= 45 && !promptActive&& !failpannel.activeSelf)
        {
            promptActive = true;
            textPrompt.gameObject.SetActive(true);
        }
        if (promptActive && !failpannel.activeSelf)
        {
            textPrompt.text = "Ad loading in : " + (50 - timeAsInt).ToString();
        }

        if (timeAsInt >= 50)
        {
            promptActive = false;
            textPrompt.gameObject.SetActive(false);
            //nadeem
            CASAds.instance.ShowInterstitial();
           // AdsManager.instance?.ShowInterstitialWithoutConditions();
           
            time = 0; // Reset the timer
        }
    }
}
