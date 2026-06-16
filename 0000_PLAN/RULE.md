# RULE.md — `0000_PLAN` 작업 규칙

이 폴더(`0000_PLAN`)에서 작업하는 모든 작업자(사람·AI)는 작업 **시작 전에 이 파일을 먼저 읽고**, 작업 중·후에 이 규칙을 지킨다.
대상 산출물은 PMLE 18주 학습 플랜(인터랙티브 HTML)과 그 부속 자료다.

---

## 0. 폴더 구조 (Single Source of Truth)

```
0000_PLAN/
├─ PMLE_18week_plan_source.mhtml   # 원본 스냅샷(백업, 수정 금지)
├─ PMLE_18week_study_plan.html                  # 작업 대상: 새 standalone 인터랙티브 HTML
├─ RULE.md                                  # 본 파일(작업 규칙)
├─ HISTORY.md                               # 작업 이력(작업할 때마다 갱신, §6)
├─ reports/                                 # 모든 보고서 파일 전용 폴더(§5)
├─ archive/                                  # 산출물 버전별 백업 전용 폴더(§0.1)
└─ (작업용 임시파일은 `_`로 시작; 산출물 확정 후 삭제)
```

- **원본 `.mhtml`은 백업이며 절대 직접 수정하지 않는다.** 변경은 새 `.html`에서만 한다.
- 임시/중간 파일은 파일명을 `_`로 시작해 구분하고, 작업이 끝나면 정리한다.

### 0.1 버전 백업 규칙 (필수)

1. **산출물 HTML을 변경하기 전에, 현재 버전을 `archive/`에 스냅샷으로 복사**한다(제자리 수정으로 이전 버전이 사라지지 않게).
2. 파일명 규칙: `archive/<원본파일명(확장자 제외)>__<YYYY-MM-DD>_v<번호>_<요약>.html`
   - 예: `archive/PMLE_18week_study_plan__2026-06-15_v3_lab-links.html`
   - 버전 번호는 단조 증가. 같은 날 여러 번이면 `_v3`, `_v4`… 로 구분.
3. 작업용 라이브 파일은 항상 `PMLE_18week_study_plan.html`(버전 없는 이름) 하나로 유지하고, **확정된 변경 직후** 새 버전을 `archive/`에 적재한다.
4. `archive/` 안의 파일은 **수정·삭제하지 않는다**(읽기 전용 이력). 정리가 필요하면 보고서로 사유를 남긴 뒤 진행한다.
5. 원본 `.mhtml`은 v0(원본)으로 간주하며 그대로 보존한다.

---

## 1. 할루시네이션 방지 규칙 (최우선)

GCP / PMLE 시험 / 제품·랩 이름은 사실 정확성이 생명이다. 다음을 **반드시** 지킨다.

1. **모르면 지어내지 않는다.** 랩 이름, 시험 문항 수·합격점·시간, 가격/단가, API 파라미터, 메뉴 명칭 등 확실하지 않은 사실은 추측으로 단정하지 않는다.
2. **불확실한 내용은 명시적으로 표시한다.**
   - 학습 카드/텍스트: 문구 끝에 ` (확인필요)`를 붙인다.
   - 퀴즈 문항: 데이터에 `"verify": true`로 표시한다(UI에서 "확인필요" 배지로 노출).
3. **필요하면 웹 검색으로 검증한다.** 핵심·load-bearing 사실(예: 제품 리브랜딩, 시험 도메인·비중)은 1차 출처(Google Cloud 공식 문서/시험 가이드)로 검증하고, 검증 출처를 보고서(`reports/`)에 남긴다.
4. **원본 출처 우선.** 강의 콘텐츠/시험 가이드는 항상 **공식 Exam Guide와 공식 샘플 문제**를 기준점으로 둔다(원본 플랜 footer 원칙 유지).
5. **원본 작성자의 전제는 보존한다.** 사용자가 제공한 원본(.mhtml)의 사실 주장(예: Vertex AI → Gemini Enterprise Agent Platform 전환)은 임의로 바꾸지 않고, 검증된 경우 그대로 사용한다.
   - 검증 완료: Vertex AI는 **Gemini Enterprise Agent Platform**(약칭 Agent Platform)으로 리브랜딩됨(Cloud Next '26, 2026-04-22).
   - 검증 완료: PMLE 2026 공식 6개 도메인 = Section 1 Architect low-code AI solutions(13%) / Section 2 Collaborate within and across teams to manage data and models(16%) / Section 3 Scale prototypes into ML models(21%) / Section 4 Serve and scale models(20%) / Section 5 Automate and orchestrate ML pipelines(18%) / Section 6 Monitor AI solutions(13%).

---

## 2. 콘텐츠/표기 규칙

1. **코스·랩·제품·시험 도메인 등 고유명사는 영어로** 통일한다. 한글·영어를 애매하게 섞지 않는다(예: "섹션 2 · 데이터·모델 협업 관리" → `Section 2 · Collaborate to manage data & models`).
   - 단, 학습자용 설명/지시 문장(산문)·학습 카드 내용은 한국어를 유지하되 기술 용어는 영어로 적는다.
2. **랩 이름은 원본에 적힌 그대로** 사용한다(임의 번역/변형 금지). 현행 카탈로그와 다를 수 있으면 `(확인필요)`.
3. **주간 일정은 기본 주 4회**(일 1.5h)이며, **여유가 생기면 5회차(선택)**를 추가로 진행한다. 5회차·복습일 카드는 별도로 제공한다(아래 §3, §4).
4. **실습은 "글자만" 적지 않고, 실제 작업으로 연결한다.** 일간 활동·학습 카드·자료의 제품/콘솔/랩 용어는 **하이퍼링크**로 만들어, 클릭하면 해당 **작업 공간(콘솔)·실습 랩·공식 문서**로 바로 이동하게 한다. 또한 "어떤 식으로 작업하는지"(작업 순서·산출물)를 학습 카드로 함께 제공한다.
   - 콘솔 작업 공간 → `console.cloud.google.com/...`, 실습 랩 → `cloudskillsboost.google/catalog?keywords=<랩명>`, 문서 → 공식 docs(불확실 시 `site:cloud.google.com` 검색)로 연결한다.
   - **링크 URL도 사실이다(§1 적용).** 정확한 deep-link 경로가 불확실하면 지어내지 말고, 안정적인 콘솔 상위 경로 또는 공식 문서 검색으로 연결한다. 구 `vertex-ai` 콘솔 경로는 Agent Platform으로 자동 리다이렉트될 수 있음을 UI에 명시한다.
   - 구현: HTML 내 `LINKS` 매핑 + `linkify()`가 본문(`.day-act`, `.wk-theme`)과 드로어(학습 카드·자료)에서 용어를 자동 링크하고, 드로어 상단에 "작업 공간·바로가기" 칩을 제공한다. 새 용어가 생기면 `LINKS`에 추가한다.
5. **`실습`(hands-on) 타입 일자에는 그 일자에 맞는 실습 랩 링크를 카드에 직접 노출한다.**
   - **검증된 실습 랩은 `DAY_LABS`에 일차별 키(`"<주>-<일>"`)로 매핑**한다. 같은 주라도 **1일차·3일차가 서로 다른 랩**을 가리켜야 한다(주 단위로 동일 링크를 깔지 말 것).
   - **링크는 반드시 “익명(비로그인)으로 실제 열리는지” WebFetch로 검증한 것만 쓴다.** 검증으로 확인된 사실:
     - ❌ `skills.google/focuses/<id>`(개별 랩) = 비로그인 시 **홈으로 리다이렉트되어 안 열림**. `…/labs/<id>` = 로그인 페이지. → **클릭 대상으로 쓰지 않는다.**
     - ✅ `skills.google/paths/17`(공식 PMLE 경로) 및 `…/paths/17/course_templates/<id>`(코스) = **익명으로 열림.**
   - 따라서 **각 주차를 그 랩이 포함된 검증된 코스(`WEEK_COURSE`)로 연결**하고, 개별 랩명은 “이 코스에서 수행할 랩”으로 텍스트 표기한다. 모든 드로어에 path 17 앵커 + 로그인 안내(`pathLine()`)를 노출한다.
   - **커리큘럼·진행도의 단일 출처는 사용자의 실제 수강 페이지 export(`LINK.html`)** 다. 거기 임베드된 JSON의 `isComplete`/`inProgress`로 코스 진행도를 읽어 `WEEK_COURSE[].st`(done/prog/todo)로 반영하고, 진행도 배지(`cstat()`)로 표시한다. **사용자 체크박스(localStorage)는 진행도 배지와 별개이며 임의로 덮어쓰지 않는다.**
   - 코스 id↔title은 LINK.html 앵커로 확정하되, **링크로 쓰기 전 WebFetch로 익명 로드를 재검증**한다(미로드 id는 제외).
   - 검증된 path 17 코스 ID(익명 로드 OK): 593(Intro to AI/ML) · 11(Feature Engineering) · 12(Keras Build/Train/Deploy) · 17(Production ML Systems) · 158(MLOps: Getting Started) · 985(Responsible AI: Fairness & Bias) · 1171(PMLE Study Guide). 191(ML Pipelines)·684 등은 익명 미로드 → 사용 금지(또는 재검증 후).
   - 제목은 현행 정식 명칭으로 정확히(예: focus 581 = “AI Platform: Qwik Start”). 구현: `WEEK_COURSE`/`COURSE_BASE`/`courseURL()`/`pathLine()`/`daySection()`/`weekLabsRefSection()`/`labRowHTML()`.
   - **링크는 추측으로 넣지 않는다.** 클릭검증 불가하면 그 한계를 사용자에게 사실대로 알리고, 검증된 상위(코스/경로) 링크로 연결한다.

---

## 3. 진행/체크 규칙 (UI 기능 정의)

1. 일간 카드마다 **체크박스**가 있고, 상태는 브라우저 `localStorage`에 저장된다.
2. **한 주의 기본 4일이 모두 체크되면 해당 주가 "완료"** 처리된다(좌측 레일 W배지에 완료 표시).
   - 5회차(선택)·복습일 카드도 체크 가능하나, **주간 완료 판정에는 포함하지 않는다(보너스/선택).**
3. 헤더의 6개 도메인 비중 막대(스펙트럼) **바로 아래에 동일 크기의 "전체 진행률" 막대**를 두어, 전체 기본 일정 중 완료 비율(%)을 표시한다.
4. **진행상태는 단일 HTML 파일로 이식 가능해야 한다(서버·외부 저장소 없이).**
   - localStorage(기기 로컬) + 파일 내장(`INITIAL_PROGRESS`) 병합으로 동작한다.
   - 헤더 툴바 제공: **💾 진행상태 포함 저장(HTML)**(현재 상태를 담은 단일 HTML 다운로드 → 공유/타 기기에서 그대로 열림), **📤 내보내기/📥 가져오기(JSON)**(백업·병합), **↺ 초기화**.
   - 자가저장 HTML은 **재오픈 시 멱등**해야 한다(자동 링크·랩행 주입을 중복 실행하지 않도록 가드). 구현: `saveHTML()`/`exportJSON()`/`importJSON()`, `data-linked` 가드.

---

## 4. 추가 학습/복습 규칙

1. **5회차(선택)**: 그 주를 더 깊게(추가 랩·심화 핸즈온) 진행하는 선택 세션. 각 주 `fifth`에 정의.
2. **복습일(팀원 결석 시)**: 한 주 일정 중 참여 못 하는 팀원이 생기면 진도 대신 복습한다. 각 주 `review`에 "무엇을·어떻게(active recall, 랩 재실행, 퀴즈 재응시, teach-back)" 정의.

---

## 5. UI 변경 & 보고서 규칙 (하네스 규칙)

1. **사용자가 명시한 부분 외의 UI는 임의로 바꾸지 않는다.** 색/레이아웃/타이포 등 기존 디자인 언어를 보존한다.
2. 부득이 UI 변경(추가 포함)이 필요하면, **변경 전/변경 내용을 보고서 파일로 작성**해 `reports/` 폴더에 제출한다.
3. **모든 보고서는 `reports/` 폴더에만** 둔다. 파일명: `reports/YYYY-MM-DD_<주제>.md`.
4. 명시적으로 허용된 UI 추가(체크박스, 전체 진행률 막대, 일간 자료 보기 드로어, 5회차·복습일 카드, 영어 도메인명 표기)는 보고서에 그 범위와 근거를 기록한다.

---

## 6. 작업 이력 규칙

1. **작업할 때마다 `HISTORY.md`를 갱신**한다(최신이 위). 각 항목: 날짜 / 작업자 / 변경 요약 / 영향 파일 / 관련 보고서.
2. 되돌리기 어려운 작업(파일 덮어쓰기·삭제, 외부 전송) 전에는 대상 확인 후 진행하고, 그 사실을 HISTORY에 남긴다.

---

## 7. 일반 작업 규칙 (하네스)

1. 날짜는 절대표기(YYYY-MM-DD)로 기록한다. (기준 today는 작업 시점 기준으로 환산)
2. 큰 변경 후에는 산출물을 직접 열어/검증해 동작을 확인하고 결과를 사실대로 보고한다(테스트 실패는 실패로 보고).
3. 한 가지 사실 = 한 군데에만 기록(중복 금지). 데이터(학습자료·퀴즈)는 단일 원천에서 관리한다.
4. 임시 파일(`_`로 시작)은 최종 산출물에 포함하지 않는다.

---

## 8. 보안 & 파일/폴더 네이밍 규칙

### 8.1 보안 (자격증명)
1. **서비스 계정 키·OAuth 토큰·API 키·`.env`·`*.pem/*.key` 등 자격증명은 절대 커밋하지 않는다.** 저장소 루트 `.gitignore`로 차단한다.
2. 새 자격증명 파일을 추가할 때 `.gitignore` 패턴에 포함되는지 확인한다(일반 `*.json`은 추적 유지하되, `*service-account*.json`·`credentials.json`·`client_secret*.json` 등은 제외).
3. 커밋 전 의심 시 `git grep`으로 `BEGIN PRIVATE KEY` / `private_key` / `AIza...` / `ya29.` 패턴을 점검한다.

### 8.2 파일/폴더 네이밍 (스크립트·링크 안전)
1. **폴더/파일명에 공백·특수문자(`·`, `-` 연속, 슬래시 등)·한글을 쓰지 않는다.** 영어 소문자 + 하이픈(kebab-case)로 적는다.
2. 실습/코스 폴더 규칙: `MMDD_kebab-english`(예: `0608_bigquery-ml-getting-started`). 한글 설명이 필요하면 폴더 내부 문서(README 등)에 적는다.
3. 산출물 파일은 ASCII 영문(예: `PMLE_18week_study_plan.html`).
4. **기존 추적 폴더/파일 rename은 반드시 `git mv`**로 수행해 이력을 보존하고, 변경 매핑(old→new)을 보고서로 남긴다.

---

## 9. 실습 링크 영속성 (필수 — 반복적으로 깨졌던 항목)

> 실습(lab) 하이퍼링크가 재구성·재라벨 때마다 깨졌다. 아래를 **모든 변경에서 강제**한다.

1. **단일 출처 = `LINK.html`.** 모든 실습 랩 링크는 사용자의 실제 수강 export(`LINK.html`)의 임베드 JSON(`/labs/<id>` href + `isComplete`/`inProgress`)에서 추출한다. 추측·임의 생성 금지.
2. **저장 위치 = `DAY_ASSIGN`(주차→일자별 랩) + `ACTUAL_LABS`(주차→전체 랩).** 각 랩은 href로 저장하되 **반드시 `course_templates/<templateId>` 경로**를 쓴다. 진행배지는 LINK.html JSON 기준.
   - ⚠️ **`course_sessions/<sessionId>` 경로 금지.** 세션은 *개인 수강 인스턴스*라 등록·기간에 종속되어 본인도 재오픈 안 되고 **공유 불가**. 템플릿 경로는 *공개 코스*라 안정·공유 가능(랩 id는 동일, 부모 경로만 다름). LINK.html이 세션 경로로 export하면(등록 코스) **반드시 템플릿 id로 변환**해 저장한다.
   - 세션→템플릿 매핑(확인됨): `39074269→593`(Intro AI/ML) · `39716873→631`(Prepare Data) · `39907361→11`(Feature Engineering) · `39939973→626`(Create ML BQML). 새 매핑은 `skills.google/course_templates/<id>` WebFetch로 제목 확인 후 사용.
3. **본문·칩 모두 링크 유지:** 모든 lab 제목을 **`linkify`의 매칭 대상으로 등록**(load 시 `LINK_MAP`에 추가 후 `LINK_RE` 재생성)한다. 그러면 `day-act` 본문의 랩 이름과 카드 칩(`labRowHTML`)·드로어(`daySection`) 모두 자동으로 링크된다. 이 등록 IIFE를 삭제하지 말 것.
4. **어떤 재구성(옵션 B, 재라벨 등)도 `DAY_ASSIGN`/`ACTUAL_LABS`를 덮어쓰면 안 되고, 바꿔야 하면 반드시 `LINK.html`에서 다시 추출**해 채운다. 표시 라벨 시프트(W-4… 등)는 **내부 주차 키를 바꾸지 않는다**(데이터 무손상).
5. **변경 후 필수 검증(매번):**
   - `/labs/` href 개수가 줄지 않았는지(현재 기준 43개 랩, /labs/ 출현 ~87회).
   - 대표 href 존재: Visitor Purchases(`612209`,`629113`), ML APIs(`629215/16/17/18`), Keras(`512769…`), Privacy(`584572/581`).
   - `node --check`로 `<script>` 문법 통과.
   - **`course_sessions/` 잔존 0건**(전부 `course_templates/`).
   - 산출물을 열어 임의 주차에서 랩 링크가 클릭되는지 확인.
6. 개별 랩 페이지는 **로그인 후** 열린다(비로그인은 홈 리다이렉트). 링크 자체는 정확해야 하며, 이 점만 UI에 안내한다.

## 10. 배포(릴리즈)

- 배포본 = `0000_RELEASE/index.html`(Vercel 대상, 단일 파일). 빌드/수정 후 `0000_PLAN/PMLE_18week_study_plan.html`를 이 경로로 복사해 갱신한다.
- 개인 export `0000_PLAN/LINK.html`(≈124MB, 인라인 style 토큰 중복이 99%)은 **.gitignore로 제외**(GitHub 100MB 한도 초과 + 개인 데이터). 푸시·배포 대상 아님.
- 레포를 Vercel에 연결할 때 Root Directory = `0000_RELEASE`. 또는 폴더 드래그앤드롭.
