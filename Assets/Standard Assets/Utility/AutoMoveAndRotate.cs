using System;
using UnityEngine;

namespace UnityStandardAssets.Utility
{
    public class AutoMoveAndRotate : MonoBehaviour
    {
        public Vector3andSpace moveUnitsPerSecond;
        public Vector3andSpace rotateDegreesPerSecond;
        public bool ignoreTimescale;
        private float m_LastRealTime;
        public float lastangle;
        public Transform start, end;
       

        public bool stoper;

        private void Start()
        {
            m_LastRealTime = Time.realtimeSinceStartup;
            Debug.Log(rotateDegreesPerSecond.value);
        }


        // Update is called once per frame
        private void Update()
        {
            if (!stoper)
            {
                float deltaTime = Time.deltaTime;
                if (ignoreTimescale)
                {
                    deltaTime = (Time.realtimeSinceStartup - m_LastRealTime);
                    m_LastRealTime = Time.realtimeSinceStartup;
                }
                //  transform.Translate(moveUnitsPerSecond.value*deltaTime, moveUnitsPerSecond.space);
                //float minangle = lastangle - 5;
                //float maxangle = lastangle + 5;
                //float currentangle = transform.eulerAngles.y - 360f;
                //Debug.Log("min angle is "+minangle);
                //Debug.Log("max angle is "+maxangle);


                //if (currentangle == lastangle)
                //{
                //    stoper = true;
                //    Debug.Log("stoppppppppppper");
                //}
                //else
                //{
               // transform.localRotation = Quaternion.Slerp(transform.localRotation, end.transform.localRotation, 2f * deltaTime);
                // transform.Rotate(rotateDegreesPerSecond.value * deltaTime, moveUnitsPerSecond.space);
                //}
               // Debug.Log(currentangle);
            }
        }


        [Serializable]
        public class Vector3andSpace
        {
            public Vector3 value;
            public Space space = Space.Self;
        }
    }
}
