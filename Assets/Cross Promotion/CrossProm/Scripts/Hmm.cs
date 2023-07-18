using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;


namespace HagridsTools
{
    namespace CrossProm
    {
        public class Hmm : MonoBehaviour
        {
            //public void OnCPTrue()
            //{
            //    CrossPromController.instance.m_AdGameObject.SetActive(true);
            //    PlayerPrefs.SetInt("Time", 1);
            //    CrossPromController.instance.InvokeNewAd();
            //}

            public void OnCPFalse()
            {
                CrossPromController.instance.m_AdGameObject.SetActive(false);
                PlayerPrefs.SetInt("Time", 2);
            }


            private void Update()
            {
                if (PlayerPrefs.GetInt("Time") == 2)
                {
                    CrossPromController.instance.m_AdGameObject.SetActive(false);
                }
            }

        }
    }
}
