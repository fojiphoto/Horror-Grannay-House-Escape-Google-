using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using EmeraldAI;

public class story5 : MonoBehaviour
{
   
    Animator tempanim;

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.tag == "Emerald AI")
        {
            other.gameObject.GetComponent<EmeraldAISystem>().enabled = false;
            Invoke("cry",0.5f);
            tempanim = other.gameObject.GetComponent<Animator>();


        }
    }

    void cry() {

        tempanim.Play("cry");
    }
}
