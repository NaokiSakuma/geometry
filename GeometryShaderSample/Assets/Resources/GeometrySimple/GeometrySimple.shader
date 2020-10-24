Shader "Unlit/GeometrySimple" {
    Properties {
        _Color ("Color", Color) = (1, 1, 1, 1)
    }
    SubShader {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass {
            CGPROGRAM
            #pragma vertex vert
            // Geometry Shaderを使用することを伝える
            #pragma geometry geom
            #pragma fragment frag

            #include "UnityCG.cginc"

            fixed4 _Color;

            struct appdata {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct g2f {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            //Geometry Shaderで処理するため、そのまま返す
            appdata vert (appdata v) {
                return v;
            }

            // 出力する頂点の最大数を指定
            [maxvertexcount(3)]
            /// <summary>
            /// Geometry Shader
            /// </summary>
            /// <param name="input">頂点シェーダーでの返り値の値</param>
            /// <param name="stream">ストリーム</param>
            void geom (triangle appdata input[3], inout TriangleStream<g2f> stream) {
                [unroll]
                for (int i = 0; i < 3; i++) {
                    // 頂点シェーダーの頂点をそれぞれ射影変換
                    appdata v = input[i];
                    g2f o;
                    o.vertex = UnityObjectToClipPos(v.vertex);
                    o.uv = v.uv;
                    // 現在のストリームに出力
                    stream.Append(o);
                }
                // 現在のストリームを終了
                stream.RestartStrip();
            }

            fixed4 frag (g2f i) : SV_Target {
                fixed4 col = _Color;
                return col;
            }
            ENDCG
        }
    }
    FallBack "Unlit/Color"
}