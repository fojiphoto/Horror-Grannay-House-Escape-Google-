using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using EmeraldAI;
using UnityEngine.AI;

public class story4 : MonoBehaviour
{
   
    Animator tempanim;

    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.tag == "Emerald AI")
        {
            other.gameObject.GetComponent<EmeraldAISystem>().enabled = false;
            other.gameObject.GetComponent<NavMeshAgent>().enabled = false;
            //other.gameObject.isStatic = enabled;
            //other.gameObject.GetComponent<EmeraldAISystem>().WalkSpeed = 0f;
            //other.gameObject.GetComponent<EmeraldAISystem>().RunSpeed = 0f;
            Invoke("cry",0.5f);
            tempanim = other.gameObject.GetComponent<Animator>();


        }
    }

    void cry() {

        tempanim.Play("cry");
    }
}
