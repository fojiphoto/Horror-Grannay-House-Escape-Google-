using UnityEngine;
using System.Collections;

public class MoveSample : MonoBehaviour
{	
    public GameObject firstcar;
	void Start(){
		iTween_new.MoveTo(gameObject, iTween_new.Hash("x", 2f, "speed", 3f, "easeType", iTween_new.EaseType.easeOutBounce));
		//parameters: iTween_new.MoveBy(gameObject, iTween_new.Hash("x", 2, "speed", 3, "easeType", iTween_new.EaseType.easeInOutBack (can add multiple types) ));
		//iTween_new.MoveBy(gameObject, iTween.Hash("x", 2, "easeType", "easeInOutExpo", "loopType", "pingPong", "delay", .1));
		//iTween_new.MoveBy(gameObject, iTween_new.Hash("x", 2, "time", 3, "easeType", iTween_new.EaseType.easeInOutBack (can add multiple types) ));
		//iTween_new.MoveTo(gameObject, iTween_new.Hash("x", 2f, "islocal", true, "easeType", iTween_new.EaseType.easeInOutBack));
	}
}

