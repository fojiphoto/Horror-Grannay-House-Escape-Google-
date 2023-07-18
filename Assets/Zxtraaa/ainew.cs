using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityStandardAssets.Characters.FirstPerson;
using UnityEngine.AI;

public class ainew : MonoBehaviour
{
    public Animator anim;

    public GameObject gameplaycontrols, playercamera;
    public AudioClip caught;
    public GameObject startingpos;

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.tag == "Emerald AI")
        {
            this.gameObject.GetComponent<FirstPersonController>().playeranim.gameObject.SetActive(false);
            this.gameObject.GetComponent<FirstPersonController>().enabled = false;
            other.gameObject.GetComponent<NavMeshAgent>().enabled = false;
            this.gameObject.GetComponent<CrosshairGUI>().enabled = false;

            Invoke("wait",3f);
            Debug.Log("animator final!!!");

            //GetComponent<AudioSource>().clip = caught;
            GetComponent<AudioSource>().PlayOneShot(caught);
            gameplaycontrols.SetActive(false);
          

            anim = other.gameObject.GetComponent<Animator>();

            anim.Play("caught");
            
            Invoke("restarting", 5f);
        }
    }


    void wait() {

        playercamera.SetActive(false);
       
    }


    void restarting() {
        playercamera.SetActive(true);
        this.gameObject.GetComponent<CharacterController>().enabled = false;
        
        this.gameObject.transform.localPosition = startingpos.transform.localPosition;
        this.gameObject.transform.localRotation = startingpos.transform.localRotation;

        this.gameObject.GetComponent<CharacterController>().enabled = true;
        this.gameObject.GetComponent<FirstPersonController>().playeranim.gameObject.SetActive(true);
        this.gameObject.GetComponent<FirstPersonController>().enabled = true;
        anim.gameObject.GetComponent<NavMeshAgent>().enabled = true;
        //other.gameObject.GetComponent<NavMeshAgent>().enabled = false;
      

     
        anim.Play("Movement");
        gameplaycontrols.SetActive(true);
        Invoke("anotherdelay",4f);


    }

    void anotherdelay() {

        this.gameObject.GetComponent<CrosshairGUI>().enabled = true;
    }

}
