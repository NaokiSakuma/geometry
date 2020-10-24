using UnityEngine;

public class MoveZObject : MonoBehaviour {
    // 移動速度
    [SerializeField]
    private float _speed;

    // リセット
    [SerializeField]
    private bool _reset;

    private Vector3 _startPos;

    void Start() {
        _startPos = transform.position;
    }
    void Update() {
        if (_reset == true) {
            _reset = false;
            transform.position = _startPos;
            return;
        }
        Vector3 nowPos = transform.position;
        nowPos.z -= Time.deltaTime * _speed;
        transform.position = nowPos;
    }
}
