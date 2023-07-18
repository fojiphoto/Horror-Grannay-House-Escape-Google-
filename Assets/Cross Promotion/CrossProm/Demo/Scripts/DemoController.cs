using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using HagridsTools.CrossProm;

public class DemoController : MonoBehaviour
{
    void Start()
    {
        if (CrossPromController.instance != null)
        {
            CrossPromController.instance.InvokeNewAd();

            CrossPromController.instance.Event_OnAdShow += TempEventShow;
            CrossPromController.instance.Event_OnAdDownload += TempEventDownloadClick;
            CrossPromController.instance.Event_OnAdQuit += TempEventQuit;
        }
    }

    void TempEventShow(GameAd _Game)
    {
        Debug.Log("Showed ad for " + _Game.m_Name);
    }

    void TempEventDownloadClick(GameAd _Game)
    {
        Debug.Log("Download clicked on " + _Game.m_Name);
    }

    void TempEventQuit(GameAd _Game)
    {
        Debug.Log("Ad quit for " + _Game.m_Name);
    }
}
