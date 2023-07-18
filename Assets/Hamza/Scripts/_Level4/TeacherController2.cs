using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TeacherController2 : MonoBehaviour
{


    private Animation anim;

   
    public GameObject FaceFrontCam;
    public GameObject BackAnimCam;
    public GameObject SideCam;
    public GameObject TableNewspaper;
    public GameObject HandNewspaper;
    
    public GameObject Scene2;
    public GameObject Scene3;

    public GameObject Player;
    public GameObject PlayerControls;

    public GameObject Frame;



    // Start is called before the first frame update
    void Start()
    {
        anim = GetComponent<Animation>();
        BackAnimCam.SetActive(true);
        anim.Play("Walking");
        
    }

    // Update is called once per frame
    void Update()
    {
        
        
    }

    public void OnTriggerEnter(Collider other)
    {
        
        if (other.tag == "facecamon")
        {
            FaceFrontCam.SetActive(true);
            BackAnimCam.SetActive(false);
        }
        
        if (other.tag == "sidecamon")
        {
            SideCam.SetActive(true);
            FaceFrontCam.SetActive(false);
            anim.Play("Idle");
            TableNewspaper.SetActive(true);
            HandNewspaper.SetActive(false);
            Invoke("SceneOn",1.5f);
        }
        if (other.tag == "dooranim")
        {
            GameObject.FindGameObjectWithTag("maindoor").GetComponent<Animator>().enabled = true;
        }
    }


    public void SceneOn()
    {
        Scene2.SetActive(false);
        Scene3.SetActive(true);
        Player.SetActive(true);
        Frame.SetActive(true);
        PlayerControls.SetActive(true);
        GameObject.FindGameObjectWithTag("Player").GetComponent<CrosshairGUI>().enabled = true;
    }
   
   
}
