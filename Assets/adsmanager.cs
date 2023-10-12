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

    private void Update()
    {
        time += Time.deltaTime;
        int timeAsInt = (int)time;
        if (timeAsInt >= 25 && !promptActive)
        {
            promptActive = true;
            textPrompt.gameObject.SetActive(true);
        }
        if (promptActive)
        {
            textPrompt.text = "Ad loading in : " + (30 - timeAsInt).ToString();
        }

        if (timeAsInt >= 30)
        {
            promptActive = false;
            textPrompt.gameObject.SetActive(false);
           // AdsManager.instance?.ShowInterstitialWithoutConditions();
           
            time = 0; // Reset the timer
        }
    }
}
