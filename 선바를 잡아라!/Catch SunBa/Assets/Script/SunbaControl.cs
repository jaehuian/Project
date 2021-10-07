using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class SunbaControl : MonoBehaviour
{
    public string SunbaName;

    int SunbaCount=1;
    RectTransform Sunba;
    Vector2 Sunba_origin_pos, Sunba_origin_rect;

    public Text countText;
    int SunbaGrade=1;
    float destroyTime = 0;

    ScoreManager ScoreM;
    SunbaManager SunbaM;
    TimeManager TimeM;
    SoundManager SoundM;

    private void Awake()
    {
        ScoreM = GameObject.Find("ScoreManager").GetComponent<ScoreManager>();
        SunbaM = GameObject.Find("SunbaManager").GetComponent<SunbaManager>();
        TimeM = GameObject.Find("TimeManager").GetComponent<TimeManager>();
        SoundM = GameObject.Find("SoundManager").GetComponent<SoundManager>();
    }

    // Start is called before the first frame update
    void Start()
    {
        Sunba = this.GetComponent<RectTransform>();
        //위치, 크기
        Sunba_origin_pos = Sunba.anchoredPosition + new Vector2(0, 50f);
        Sunba_origin_rect = new Vector2(220, 240);

        if (SunbaName == "Sunba")
        {
            //클릭횟수, 점수 세팅
            SunbaCount = Random.Range(1, 6);
            SunbaGrade = SunbaCount;
        }
        else
        {
            SunbaCount = 1;
            SunbaGrade = 1;
            destroyTime = 0;
        }

        //선바 클릭횟수 출력
        countText.GetComponent<Text>().text = SunbaCount.ToString();
    }

    // Update is called once per frame
    void Update()
    {
        //선바 등장 애니메이션
        Sunba_Animation();

        if(SunbaName!="Sunba")
        {
            Sunba_Destroy();
        }
    }
    //선바 등장 애니메이션
    void Sunba_Animation()
    {
        Sunba.anchoredPosition = Vector3.Lerp(Sunba.anchoredPosition, Sunba_origin_pos, 0.1f);
        Sunba.sizeDelta = Vector2.Lerp(Sunba.sizeDelta, Sunba_origin_rect, 0.1f);
    }

    //일반 선바 클릭
    public void Sunba_Click()
    {
        SoundM.play_sunba();

        //클릭 횟수 차감
        SunbaCount--;
        //선바 텍스트 업데이트
        countText.GetComponent<Text>().text = SunbaCount.ToString();

        //클릭 완료
        if(SunbaCount<=0)
        {
            SunbaCount = 0;

            //스코어 업데이트
            ScoreM.add_Score(SunbaGrade);

            //선바 파괴
            Destroy(this.gameObject);
        }
    }

    //벌꿀바 클릭(시야 방해)
    public void SunbaB_Click()
    {
        SoundM.play_bee();

        if(SunbaM.startBlind==false)
            SunbaM.startBlind = true;

        //클릭 횟수 차감
        SunbaCount--;
        //선바 텍스트 업데이트
        countText.GetComponent<Text>().text = SunbaCount.ToString();

        //클릭 완료
        if (SunbaCount <= 0)
        {
            SunbaCount = 0;

            //선바 파괴
            Destroy(this.gameObject);
        }
    }
    //꾸벅바 클릭(시간 정지: 3초)
    public void SunbaS_Click()
    {
        TimeM.checkStop = true;
        SunbaM.stopTime = true;
        SunbaCount--;
        //클릭 완료
        if (SunbaCount <= 0)
        {
            SunbaCount = 0;

            //선바 파괴
            Destroy(this.gameObject);
        }
    }
    //분노바 클릭(시간감소:3초)
    public void SunbaAn_Click()
    {
        SoundM.play_angry();

        TimeM.checkMinus = true;

        SunbaCount--;
        //클릭 완료
        if (SunbaCount <= 0)
        {
            SunbaCount = 0;

            //선바 파괴
            Destroy(this.gameObject);
        }
    }
    //주정바 클릭(스코어2배:5초)
    public void SunbaAl_Click()
    {
        SoundM.play_alcohol();

        if(ScoreM.checkFever==false)
            ScoreM.checkFever = true;

        SunbaCount--;
        //클릭 완료
        if (SunbaCount <= 0)
        {
            SunbaCount = 0;

            //선바 파괴
            Destroy(this.gameObject);
        }
    }
    //일정 시간후 선바 파괴
    void Sunba_Destroy()
    {
        destroyTime += Time.deltaTime;

        if (destroyTime >= 3)
        {
            //선바 파괴
            Destroy(this.gameObject);
        }
    }
}