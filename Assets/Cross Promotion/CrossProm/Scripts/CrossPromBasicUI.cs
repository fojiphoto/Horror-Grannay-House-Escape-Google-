using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace HagridsTools
{
    namespace CrossProm
    {
        public class CrossPromBasicUI : MonoBehaviour
        {
            public void ExitButtonClicked()
            {
                CrossPromController.instance.OnQuitClick();
            }

            public void DownloadButtonClicked()
            {
                CrossPromController.instance.OnDownloadClick();
            }


            //public void ExitButtonClicked_1()
            //{
            //    CrossPromController.instance.OnQuitClick_1();
            //}

            //public void DownloadButtonClicked_1()
            //{
            //    CrossPromController.instance.OnDownloadClick_1();
            //}
        }
    }
}