using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;


namespace HagridsTools
{
    namespace CrossProm
    {

        public class Hmm1 : MonoBehaviour
        {
            public void Start()
            {
               // CrossPromController.instance.m_AdGameObject.SetActive(true);
                PlayerPrefs.SetInt("Time", 1);
                CrossPromController.instance.InvokeNewAd();
            }
        }
    }

}
