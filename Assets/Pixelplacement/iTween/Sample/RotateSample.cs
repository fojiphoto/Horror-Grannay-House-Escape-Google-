using UnityEngine;
using System.Collections;

public class RotateSample : MonoBehaviour
{	
	void Start(){
		iTween_new.RotateBy(gameObject, iTween_new.Hash("x", .25, "easeType", "easeInOutBack", "loopType", "pingPong", "delay", .4));
	}
}

