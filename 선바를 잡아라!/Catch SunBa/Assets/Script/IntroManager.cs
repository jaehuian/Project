using System.Collections;
using System.Collections.Generic;
using UnityEngine;
//UI
using UnityEngine.UI;

public class IntroManager : MonoBehaviour
{
    Vector2 sunba_origin_rect, sunba_origin_pos, title_origin_rect, title_origin_pos;
    RectTransform sunba, title;
    GameObject button;

    private void Awake()
    {
        sunba = GameObject.Find("Sunba").GetComponent<RectTransform>();
        title = GameObject.Find("Title").GetComponent<RectTransform>();
        button = GameObject.Find("Canvas").transform.FindChild("Start").gameObject;

        //버튼 비활성화
        button.GetComponent<Button>().interactable = false;

        //위치, 크기 
        sunba_origin_rect = new Vector2(680, 0);
        sunba_origin_pos = new Vector3(680, 0, 0);
        sunba.sizeDelta = new Vector2(0, -680);
        sunba.anchoredPosition = new Vector3(0, 0, 0);

        title_origin_rect = new Vector2(700, 400);
        title_origin_pos = new Vector3(-50, -30, 0);
        title.sizeDelta = new Vector2(0, 0);
        title.anchoredPosition = new Vector3(0, 0, 0);

    }
    // Start is called before the first frame update
    void Start()
    {
    }

    // Update is called once per frame
    void Update()
    {
        //선바, 타이틀 애니메이션
        sunba.sizeDelta = Vector2.Lerp(sunba.sizeDelta,sunba_origin_rect,0.1f);
        sunba.anchoredPosition = Vector3.Lerp(sunba.anchoredPosition, sunba_origin_pos, 0.1f);

        title.sizeDelta = Vector2.Lerp(title.sizeDelta, title_origin_rect, 0.1f);
        title.anchoredPosition = Vector3.Lerp(title.anchoredPosition, title_origin_pos, 0.1f);

        //버튼 활성화
        Invoke("button_set", 2f);
    }

    //버튼 활성화
    void button_set()
    {
        button.GetComponent<Button>().interactable = true;
    }
}
