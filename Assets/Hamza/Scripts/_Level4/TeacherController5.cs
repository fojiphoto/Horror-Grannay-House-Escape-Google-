using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TeacherController5 : MonoBehaviour
{

    public GameObject FaceFrontCam;
    public GameObject SideCam;
    private Animation anim;

    public GameObject TableNewsPaper;

    public GameObject TableNewsPaper1;


    public GameObject TableNewsPaper2;

    void Start()
    {
        anim = GetComponent<Animation>();
        TableNewsPaper.SetActive(false);
        anim.Play("Pick");
        
        Invoke("Shock", 1.3f);
        
    }

    public void Shock()
    {
        TableNewsPaper1.SetActive(false);
        TableNewsPaper2.SetActive(true);
        anim.Play("Shock");
        Invoke("LevelComplete",2.0f);
        
    }

    public void LevelComplete()
    {
        GamePlayUI.Instance.OnComplete();
    }
}
