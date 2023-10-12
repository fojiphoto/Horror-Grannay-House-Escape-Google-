using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;
using UnityEngine.UI;

public class ainew1 : MonoBehaviour
{
    public Animator anim;


    // Update is called once per frame

    public GameObject[] Kids;
    public GameObject failcamera, fading;
    //public Text lifetext;
   // public int life;

    public void Start() {
        if (PlayerPrefs.GetInt("life") <= 1)
        {
            PlayerPrefs.SetInt("life", 1);
        }

        if (PlayerPrefs.GetInt("life") > 5)
        {
            PlayerPrefs.SetInt("life", 5);
        }

       // life = PlayerPrefs.GetInt("life");
        //PlayerPrefs.SetInt("life", life);
    }


    public void EnableCameraFail() {

        //this.gameObject.GetComponent<NavMeshAgent>().enabled = false;
        //this.gameObject.GetComponent<NavMeshAgent>().speed = 0f;
        //this.gameObject.isStatic = true;

        //failcamera.GetComponent<Camera>().rect = new Rect(0f,0f,1f,1f);
        Invoke("newfail", 4f);
        fading.SetActive(true);
       fading.GetComponent<Animator>().Play("Fading");
        
        failcamera.SetActive(true);
        Kids[0].SetActive(true);

       
      
        Invoke("OnFail",4.5f);

    }

    public void newfail() {

        GamePlayUI.Instance.OnFail();

    }

    public void OnFail()
    {
        failcamera.SetActive(false);
        Kids[0].SetActive(false);

        Invoke("fadingwait",3f);
      
        // GamePlayUI.Instance.OnFail();
    }

    void fadingwait() {
        fading.GetComponent<Animator>().Play("Fading0");
        fading.SetActive(false);

    }


    public void MakeNormalEyes()
    {


    }


 

}
