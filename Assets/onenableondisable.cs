using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class onenableondisable : MonoBehaviour
{
    private void OnEnable()
    {
        //nadeem
        CASAds.instance.ShowMrecBanner(CAS.AdPosition.BottomLeft);
        //AdsManager.instance?.ShowMRec();
    }
    private void OnDisable()
    {
        //nadeem
        CASAds.instance.HideMrecBanner();
        //AdsManager.instance?.HideMRec();
    }
}
