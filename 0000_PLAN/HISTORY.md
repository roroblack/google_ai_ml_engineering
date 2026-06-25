# HISTORY.md — `0000_PLAN` 작업 이력

> 최신 항목이 위로 옵니다. 작업할 때마다 갱신합니다(규칙: [RULE.md](RULE.md) §6).
> 형식: 날짜 / 작업자 / 변경 요약 / 영향 파일 / 관련 보고서

---

## 2026-06-25 — Claude (AI 작업자) — v26: 네오 브루탈리즘 디자인 + 캘린더 개요 + 일별 날짜 표시

**요약:** 3가지 대규모 UI 개선. 콘텐츠(퀴즈·실습 링크·핵심 포인트) 전혀 변경 없음.

**① 네오 브루탈리즘 스타일 적용**
- 전체 색상 팔레트 교체: 배경 `#EFE6D5`(따뜻한 미색), 본문 텍스트 `#322A26`(짙은 갈색), 테두리 `#322A26`(ink 색상 통일)
- 모든 카드(`.day`, `.wk-head`, `.card-block`, `.seg`)에 `border: 2px solid var(--ink)` + 오프셋 `box-shadow: 3~4px 4px 0 var(--ink)` 적용
- 둥근 모서리 최소화 (`border-radius: 4px` 이하), 그라디언트 → 단색 flat fill 전환
- 버튼(`.mat-btn`, `.lab-link`, `.tab`) 두꺼운 테두리 + 오프셋 그림자
- 신규 CSS 클래스 추가: `mark`/`.concept-yellow` (`#FFF3B3`), `blockquote` (`#E1F5FE`), `.alert-pink` (`#FFEAEA`)

**② 개요(ov) 탭 → 캘린더 그리드 교체**
- 기존 18행 표 → 6열 카드 그리드로 전면 교체 (이전 4주 + 현재 18주 구분 표시)
- 각 주차 카드: 주차번호·테마·도메인 칩·날짜 범위(예: `6/16~6/19`)·4개 완료 도트·상태 배지(완료/진행중/예정)
- 상단 요약 스탯 5개: 전체 진행률 · 주차 완료 · 진행 중 · 남은 주차 · 예상 완료일
- 카드 클릭 시 해당 주차 탭으로 이동; 체크박스 변경 시 캘린더 도트 실시간 갱신

**③ 일별 날짜 표시**
- `STUDY_START = 2026-06-16` 기준으로 각 `.day` 카드 헤더에 날짜 자동 삽입 (예: `6/16(월)`)
- 이전 4주(W-4~W-1) 스킵, 현재 학습 18주(W1~W18)만 표시
- `.day-date` CSS 클래스 (미색 배경, 모노 폰트)

**검증:** `node --check` 2스크립트 통과 · JS 구문 오류 0 · 파일 크기 451KB(↑3KB)

**영향 파일:**
- `PMLE_18week_study_plan.html` (v26, CSS 20+개 규칙 수정 + 신규 CSS 추가 + ov 패널 교체 + JS 추가)
- `archive/PMLE_18week_study_plan__2026-06-25_v26_neobrutalism-calendar-dates.html` (백업)
- `HISTORY.md` (이 항목)

---

## 2026-06-17 (am) — Claude (AI 작업자) — 릴리즈 폴더 + GitHub 푸시 + LINK.html 추적 제외

**요약:** 배포 워크플로 구축 및 깃 정리.
- **`0000_RELEASE/index.html`** 신설 = Vercel 배포본(플랜 단일 파일 복사). RULE §10 추가(빌드 후 이 경로로 복사).
- **`.gitignore`에 `0000_PLAN/LINK.html` 추가 + 추적 해제.** (LINK.html 124MB의 99%가 인라인 style 토큰 중복 → GitHub 100MB 한도 초과·개인데이터.)
- **GitHub 푸시**(`roroblack/google_ai_ml_engineering` main, 35795a2→99b57ca): 미푸시 커밋에서 LINK.html 제거 후 재구성. 범위 = `0000_PLAN`+`0000_RELEASE`+`.gitignore`(64파일). 개인 랩 산출물 폴더는 미푸시(로컬 유지).
- 임시 `0000_PLAN/site/` 제거.

**검증:** push 성공 · main↔origin 동기화 · 0000_RELEASE 원격 반영 · LINK.html 원격 부재 · 5MB 초과 staged 0 · 시크릿 스캔 매치는 RULE/리포트의 패턴 예시(실제 키 아님).

**영향 파일:** `0000_RELEASE/`(신규), `.gitignore`, `0000_PLAN/RULE.md`(§10), GitHub main.

---

## 2026-06-16 (al) — Claude (AI 작업자) — CSS 빈 선언 잔재 제거(IDE 빨간줄)

**증상:** `.wk-head`에 `border-image-source/slice/outset/repeat: ;` 빈 값 4개 → IDE linter 경고(빨간줄).
**원인:** (ai)의 정리 정규식이 `border-*-color/style/width`만 처리, `border-image-*`는 누락.
**픽스:** `<style>` 내 **모든 빈 선언(`속성: ;`) 일괄 제거**(4건) + 잉여 공백 정리. `.wk-head`는 유효 속성만 남음.
**검증:** 파일 내 빈 선언 0 · `node --check` 2스크립트 통과.
**영향 파일:** `PMLE_18week_study_plan.html`(v25), `archive/...v25_css-cleanup.html`

---

## 2026-06-16 (ak) — Claude (AI 작업자) — 랩 링크 안 열림 픽스: course_sessions → course_templates

**증상(사용자 제보):** 내가 건 `…/course_sessions/39939973/labs/612209`는 안 열리는데, 친구에게 공유해도 열리는 `…/course_templates/626/labs/612209`는 열림.

**원인:** `course_sessions/<id>`는 *개인 수강 인스턴스*(등록·기간 종속, 공유·재오픈 불가). `course_templates/<id>`는 *공개 코스 템플릿*(안정·공유 가능). 랩 id는 동일, 부모 경로만 다름. LINK.html이 등록 코스를 세션 경로로 export해서 그대로 썼던 것.

**픽스:** 모든 `course_sessions/<sid>` → `course_templates/<tid>` 변환(233곳). 매핑은 공식 `skills.google/course_templates/<id>` 제목으로 교차검증: 39074269→593(Intro AI/ML) · 39716873→631(Prepare Data) · 39907361→11(Feature Engineering) · 39939973→626(Create ML BQML). W5 코스 링크도 626으로 정정.

**검증:** `course_sessions/` 잔존 0 · /labs/ 160 동일 · 사용자 사례 `course_templates/626/labs/612209` 생성 확인 · `node --check` 2스크립트 통과.

**RULE 갱신:** §9-2에 "세션 경로 금지·템플릿 강제 + 세션→템플릿 매핑", §9-5에 "course_sessions 잔존 0건" 검증 추가.

**영향 파일:** `PMLE_18week_study_plan.html`(v24), `archive/...v24_template-lab-links.html`, `RULE.md`, `reports/2026-06-16_픽스-세션링크-템플릿전환.md`

---

## 2026-06-16 (aj) — Claude (AI 작업자) — 시험 로지스틱스 공식 확정·반영(자율 처리)

**요약:** 사용자 방침("검증 가능·시간 드는 작업은 지시 없이 직접 처리")에 따라, 보류했던 시험 형식을 **공식 페이지로 확인 후 반영**.

**공식 확인값(cloud.google.com 인증 페이지):** 2시간 · 50~60문항(객관식+복수정답) · $200(+세금) · 온라인 감독 또는 시험센터(Pearson VUE) · 영어/일본어 · 선수조건 없음(권장 3년+ 경력·GCP 1년+) · 갱신은 갱신 FAQ.

**반영:** (1) 시험대비 ① 주차 상단 **공식 정보 배너**(출처 링크 포함), (2) W18 환경점검 카드의 "공식 가이드로 확인" 문구를 **확정 수치 + 출처 링크**로 교체.

**검증:** `node --check` 2스크립트 통과 · 배너/수치/Pearson 링크 존재.

**영향 파일:** `PMLE_18week_study_plan.html`(v23), `archive/...v23_official-exam-facts.html`, 메모 `work-autonomously-on-verifiable-tasks.md`

---

## 2026-06-16 (ai) — Claude (AI 작업자) — 코드리뷰 반영: 드로어 재생성 + 진행률 분리 + 레거시/CSS 정리

**요약:** 외부 코드리뷰 검증 후 결정사항 반영. (1) 📋 학습자료 **드로어 재생성**(옛 PLAN_DATA 1~18 → 새 22주). (2) 진행률 **현재 학습/시험주만** 집계(과거 4주 제외). (3) **5일 주차 헤더 명시**. (4) **W5 코스 링크 복구**. (5) 레거시 정리: TOTAL_BASE 제거, CSS 빈 border 제거, 확인필요 53→3(콘텐츠선 제거).

**세부 (리뷰 6지적 대응):**
- ①④ **PLAN_DATA·DAY_LABS 재생성 + openMat 재작성**: 드로어가 새 주차의 코스·일자 랩·산출물 카드·주간 퀴즈(보기 클릭 정답/해설)를 정확히 표시. w19~22(시험주)도 카드 표시. → 옛 테마 불일치/빈 드로어 해소.
- ② **진행률 분모 = 현재 학습/시험주(과거 제외)**: `isCurrent`(data-wk>PAST_WEEKS). 라벨 "현재 학습 진행률 N%". `TOTAL_BASE` 죽은 코드 제거.
- ③ **5일 주차**: 헤더에 "이 주 N일" 명시(세션 5개 주). data-day=5는 진짜 학습일이라 유지(선택일은 f로 별도).
- ⑤ CSS 빈 `border-*` longhand 제거. 확인필요 53곳(전부 옛 PLAN_DATA) → 재생성으로 소멸(잔여 3은 드로어 UI 코드 문자열).
- W5(Create ML BQML) WEEK_COURSE에 `u`(course_sessions/39939973) 부여 → 코스 링크 동작. 3(Notebooks)·19(보강)은 path-17 폴백.
- 시험주 "확인필요" 문구 → "공식 시험 가이드로 최종 확인"으로 교체(공식 출처 링크 리포트에 명시).

**검증:** `node --check` 2스크립트 통과 · PLAN_DATA 22주(JSON 유효) · rev 25·퀴즈 90·강의 14 · /labs/ 160(드로어 랩링크 포함) · TOTAL_BASE 0 · 빈 border 0.

**견해:** 리뷰 6지적 중 5개 타당(반영), `data-day=5`만 진단 일부 오류(선택일 아닌 실학습일). 근본원인=수작업 원본의 레거시 잔재 → 이번에 제거.

**영향 파일:** `PMLE_18week_study_plan.html`(v22), `archive/...v22_drawer-regen-progress-cleanup.html`, `reports/2026-06-16_리뷰검증-내견해.md`, `reports/2026-06-16_구현-v8-드로어재생성-정리.md`

---

## 2026-06-16 (ah) — Claude (AI 작업자) — 복습 접힘 기본 + 퀴즈 보기 선택형(정답/오답·선택지별 이유) + 구성 분석 리포트

**요약:** (1) 📌핵심 포인트·❓퀴즈를 **기본 접힘**(`<details>`)으로 깔끔하게, 펼쳐야 표시. (2) 퀴즈 클릭 **3단계 순환**: 질문→보기→정답→다시 접힘(0). (3) 보기를 **클릭 선택** 가능 → 정답이면 ✓정답, 오답이면 ✗내 선택 표시, **선택지마다 맞고 틀린 이유(why)** 를 정답과 함께 노출. (4) 전체 구성 분석 리포트 작성.

**세부:**
- 퀴즈 콘텐츠 재생성(서브에이전트 3): 실습당 5문항, 각 문항 **선택지 4개마다 why**(정답 이유 + 오답별 구체 이유) + 포인트 6.
- UI: 핵심/퀴즈 각각 `<details>`(rev-sum), 퀴즈는 보기 선택형 .rq(데이터 data-ans/data-stage). JS = 이벤트 위임(qx 펼치기/접기 · 보기 선택 · 질문 0→1→2→0 순환).
- 강의 상세·랩링크·진행률·중요도가중·보충패널 유지.

**검증:** `node --check` 2스크립트 통과 · 핵심포인트 18 + 퀴즈 18 접이식 · 퀴즈 90문항(보기 선택형) · 강의 14블록 · /labs/ 127.

**구성 통계:** 과거 4주(복습용 17h) + 현재 18주(일자 카드 111.5h: 학습 15 + 시험대비 3) + 수시 복습 18카드 + 5일차/복습일. 도메인 비중 S3 21%·S4 20%·S5 18% 중심.

**영향 파일:** `PMLE_18week_study_plan.html`(v21), `archive/...v21_collapsible-selectable-quiz.html`, `reports/2026-06-16_구현-v7-접힘-보기선택퀴즈.md`, `reports/2026-06-16_분석-전체구성.md`

---

## 2026-06-16 (ag) — Claude (AI 작업자) — 심화 퀴즈(5문항·3단계 공개) + 강의 상세 모듈 목록(링크·★중요표시)

**요약:** (1) 복습 카드 퀴즈를 **실습당 5문항**으로 확장 + 핵심 포인트 6개(줄바꿈), 그것만 풀어도 복습 완료 수준. (2) 퀴즈 UX: **질문만 표시 → 클릭 시 보기 → 다시 클릭 시 정답·해설**, 카드별 **⊕ 모두 펼치기 / ⊖ 모두 접기**. (3) 강의를 "강의 모듈 수강"으로만 두지 않고, **코스별 강의 상세 모듈/영상 목록 + 링크**를 접이식으로 표시, **★=핵심 모듈** 표시.

**세부:**
- 17개 실습 심화 퀴즈(5문항, 시나리오형, 정답+오답 이유 해설)를 서브에이전트 3개로 작성(안정 개념, 환각 방지).
- 강의 모듈/영상 목록·링크는 **LINK.html에서 추출**(RULE §9): 코스별 modules(제목)+activities(video/document/quiz title·href). ★ 휴리스틱 = 개요/요약/퀴즈/랩 제외한 콘텐츠 모듈.
- 퀴즈 인터랙션 JS(이벤트 위임, data-stage 0→1→2) `</body>` 앞 별도 script로 주입. 강의 목록은 native `<details>`.
- 진행률·5일차·복습일·중요도가중·보충패널·시간칩 유지. 복습 퀴즈는 진행률 미포함.

**검증:** `node --check` 2개 스크립트 통과 · 강의 상세 14블록 · 퀴즈 90문항(18랩×5) · ⊕/⊖ 18쌍 · /labs/ 127 유지.

**영향 파일:** `PMLE_18week_study_plan.html`(v20), `archive/...v20_deep-quiz-reveal-lectures.html`, `reports/2026-06-16_구현-v6-심화퀴즈-강의상세.md`

---

## 2026-06-16 (af) — Claude (AI 작업자) — 각 실습별 복습 카드 + 디테일 복원(시간배분·핵심·실제 퀴즈)

**요약:** v18의 "주당 1개 일반 수시 카드" → **실습마다 1개씩 복습 카드**로 변경. 각 카드에 **시간 배분(15m 핵심/10m 퀴즈/15m 재현 등) + 핵심 포인트 2~3개 + 실제 퀴즈(질문·4지선다·정답·해설)** 를 인라인 표기 → "그것만 봐도 학습 가능". v13_stable 수준의 디테일 복원.

**세부:**
- 17개 필수 실습의 복습 콘텐츠(핵심·퀴즈·시간배분)를 서브에이전트 3개로 작성(안정 개념 기반, 환각 방지).
- `rev_card()`: 실습별 수시(무날짜) 카드 — `.rev-detail`(핵심 포인트) + `.rev-q`(퀴즈 Q/보기/정답/해설). 강의 전용 주차는 일반 수시 1개.
- 진행률 미포함(data-day="q1..qN" 비숫자), 5일차/복습일 유지.
- 검증: `node --check` 통과 · 22섹션 · rev 카드 25(상세 19 + 일반 6) · /labs/ 127 · W1=실습 복습카드 4개.

**영향 파일:** `PMLE_18week_study_plan.html`(v19), `archive/...v19_per-lab-review-detail.html`, `reports/2026-06-16_구현-v5-실습별-복습카드.md`

---

## 2026-06-16 (ae) — Claude (AI 작업자) — 구현: 계획서 v4 전체 반영(중요도 가중·스킵·시험대비·수시복습)

**요약:** 이전 계획서(v4 + §5.1)를 HTML에 전부 구현. 중요도 가중 + 스킵(보충자료) + 시험대비 W16~18 + 파트/비중% 칩 + 일자=실습/강의 + 복습=무날짜 수시카드.

**세부:**
- 구조: **과거 4주 + 현재 18주(학습 W1~W15 + 시험대비 W16~18) = 22주.** rail에 📦 보충 탭.
- 중요도 가중: FE·Keras·Production 압축(강의 skim 0.5~0.6, 핵심 랩만), 생성형 AI 증강(Create GenAI Apps 2주)·보강주(W15). 저중요 랩 8개 → **📦 보충 자료 패널**(여유 시).
- 각 주 헤더에 **파트 칩**(Sx · 도메인 · 비중%) + 개요표 파트/비중 열.
- 일자(4일)는 **실습+강의로 시간 채움**(시간칩·⏱합계·2h 상향). **복습·퀴즈=무날짜 "수시" 카드**(점선/회색, data-day=q, 주간완료 미포함). 5회차·복습일 카드 유지(현재 주차).
- 시험대비 W16~18: 진단(샘플+모의1)·약점/케이스/의사결정표/모의2·모의3·4+빈출정리+컨디션.
- JS: 진행률을 **DOM 기반(isBase, 숫자 data-day만)**으로 교체(변동 일수·수시카드 제외). 랩 링크 LINK.html href(§9)·진행배지 유지.
- 검증: `node --check` OK, 22 섹션, 파트칩 22, 수시/5회차/복습일 각 18, /labs/ 127, 보충 Bracketology 등.

**일정:** 학습 15주 + 시험대비 3주 = 현재 18주, 종료 ~11월 초~중순.

**영향 파일:** `PMLE_18week_study_plan.html`(전면 재구성), `HISTORY.md`, `archive/…v18…`

**롤백:** v17/v14.

---

## 2026-06-16 (ad) — Claude (AI 작업자) — 계획서 v4 보강: 일자=실습+강의(%채움), 복습=무날짜 수시 카드 (HTML 미변경)

**요약:** v4에 주 구성 방식 확정 추가 — 일자(4일)는 **실습+강의로만 % 비중 맞춰 시간 채움**, "주간 마무리+퀴즈" 류 **복습은 날짜 없이 해당 파트 옆 '수시 카드'**로 두어 부족 시 체크하며 진행. 실습 개수/시간을 도메인 비중에 비례 배분. "복습일(결원)" 카드는 별개 유지.

**영향 파일:** `reports/2026-06-16_계획서-v4-중요도가중-스킵-시험대비.md`(§5.1 추가), `HISTORY.md` (HTML 미변경)

**대기:** 이 v4(보강 포함)로 재빌드 승인.

---

## 2026-06-16 (ac) — Claude (AI 작업자) — 계획서 v4(중요도 가중·스킵·시험대비 3주) (HTML 미변경)

**요약:** 결정 반영 계획서 — (1) 스킵: 중요도 가중으로 필수 랩 배정, 저중요 랩은 하단 "보충 자료(여유 시)"로 분리, (2) 시험대비 W16·17·18(3주), (3) 주차 선택 시 파트(Sx)+비중% 표시.

**세부:**
- 주차: W1 BQML(S1) · W2~3 FE(S2) · W4~5 Keras(S3) · W6~7 Production(S4) · W8 MLOps GS(S5) · W9 Manage Features(S5) · W10 GenAI+Eval(S1·S6) · W11~12 Create GenAI Apps(S1) · W13 RAI Fair/Interp(S6) · W14 RAI Privacy(S6) · W15 보강·약점 · W16~18 시험대비. (현재 18주)
- 중요도 재조정: FE·Keras·Production 4→2주 압축(필수 랩만), 생성형 증강+보강주+시험대비. 보충자료 8랩(Bracketology·TF Dataset API·DNN Functional·TFDV 2·DEPRECATED Pipelines·Adv FE·Differential Privacy).
- UI(구현 시): 파트/비중 칩, 하단 보충자료 패널, 작업별 시간배분·복습 B·모든 주 ≥4세션 유지.
- 일정: 필수 콘텐츠~85h, 학습 15주 + 시험대비 3주 = 18주, 종료 11월 초~중순.

**영향 파일:** `reports/2026-06-16_계획서-v4-중요도가중-스킵-시험대비.md`, `HISTORY.md` (HTML 미변경)

**대기:** v4로 재빌드 승인.

---

## 2026-06-16 (ab) — Claude (AI 작업자) — 리포트: 실제 합격 전략 리서치 (HTML 미변경)

**요약:** 합격 전략 조사 → 딜레마 해소: 코스는 완주하되 **모의고사 주도 + 약점·고비중 집중**. 중요도는 "뺄 것"이 아니라 "더 깊이 팔 곳"을 정함.

**세부(조사):** 경로 완주 / 문제은행 2~3회 + 도메인 정답률 추적 → 약점 집중 / 강의 1.25~1.5배속 / 타임드 풀모의 + 케이스·서비스선택 / 생성형 AI(Model Garden·파인튜닝·RAG) 집중 / 8~10주 / 합격선 ~70%.
**적용안:** 기초 완주(현행) + 조기 진단 모의 + 약점·고비중 루프 + 시험대비 2~3주 → ~20주(종료 11월 초~중순). 복습 B(시간정합)·모든 주 ≥4세션과 함께 구현 대기.

**영향 파일:** `reports/2026-06-16_실제합격전략-리서치.md`, `HISTORY.md` (HTML 미변경)

---

## 2026-06-16 (aa) — Claude (AI 작업자) — 리포트: 중요도 비중 vs 코스시간 배분 (HTML 미변경)

**요약:** 현재 주차는 **중요도가 아니라 코스 시간(pace) 기반**임을 확인. 시험 비중 대비 불일치(FE·Keras 과다, MLOps/파이프라인·생성형 AI·모니터링 과소). 중요도 가중 재조정 권장. 시간은 충분(콘텐츠 78h+복습≈105h ≤ 가용 110~120h)해 ~17~18주 유지 가능.

**세부:**
- 불일치: S2(16%)에 FE 24h/4주 과투자, S5(18%) 파이프라인 2주 과소, 생성형 AI(2026 강조) 2주 과소, Keras(저우선) 4주.
- 권장: FE·Keras 압축(스킴), MLOps/생성형/모니터링 증강(+보충 실습·예상문제), 시험대비 단계 고비중·신규 중심.
- 결정 요청: 중요도 가중 재조정(a) vs 현행 유지(b). a면 복습 B(시간정합)·모든 주 ≥4세션과 함께 재빌드.

**영향 파일:** `reports/2026-06-16_중요도비중-vs-시간배분-검토.md`, `HISTORY.md` (HTML 미변경)

---

## 2026-06-16 (z) — Claude (AI 작업자) — 리포트 정정: Pattern B는 ~17~18주(시간 정합)

**요약:** 사용자 지적 수용 — 이전 "B=25~28주"는 **복습을 1.5h 슬롯으로 센 오류**. 복습을 실제 크기(랩당 ~40분)로 산정하면 콘텐츠 78h + 복습 27h ≈ **105h → ~17~18주(10월 말)**, 가용 110~120h 안에 들어감. HTML 미변경.

**세부:**
- 남은 학습(1.5배속) ≈ 78h. 가용(17주×4×1.5 + 5회차) ≈ 110~120h. 복습 여유 ~32~42h.
- Pattern B 복습 정상 산정 ≈ 27h(랩 40m×26 + 강의 40m×15). 합 ~105h → ~17.5주.
- 핵심: 복습을 별도 1.5h 풀데이로 세지 말고 실제 시간(짧은 복습)으로 배치(같은 날/짧은 복습일). 그러면 1:1·2:1 리듬 유지하며 10월 말 가능.

**영향 파일:** `reports/2026-06-16_복습패턴B-정정-시간정합.md`, `HISTORY.md` (HTML 미변경)

**대기:** "B(시간 정합)+모든 주 ≥4세션" 구현 승인 + 시험대비 포함 여부.

---

## 2026-06-16 (y) — Claude (AI 작업자) — 리포트: 복습 패턴 B + 최소 4세션 (HTML 미변경)

**요약:** 패턴 B(실습1:복습1·강의2:복습1) + 모든 주 ≥4세션 적용 시 결과 산정. 1.5배속(강의 ×0.7) 반영 확인.

**세부:**
- 1.5배속 반영됨(강의 시간 ×0.7; 랩은 배속 불가 실제시간).
- 패턴 B 세션 합 ≈ 99 → 현재 **~25~28주**(복습 별도 세션으로 일정 약 2배). 종료 ~12월 초~중순(+시험대비 시 12말~1월).
- 비교: A(현행)~17주/10월중순, C(절충)~22주/11월말, B~25~28주/12월.
- 모든 주 ≥4세션 보장(복습 증가+패딩). 구현 형태: 실습일→복습일 교차, 강의2→복습1.

**영향 파일:** `reports/2026-06-16_복습패턴B-최소4일-리포트.md`, `HISTORY.md` (HTML 미변경)

**결정 요청:** A/B/C + 시험대비 포함 여부.

---

## 2026-06-16 (x) — Claude (AI 작업자) — RAI 라벨 구분 + W16·17 병합 + 4일 보장 + 카드 현재주차만

**요약:** Responsible AI 3주가 모두 "Responsible AI for Developers"로 동일 표시되던 문제 수정(`short()` 절단 원인) → 구분 라벨(sl) 도입. W16(Fairness&Bias)+W17(Interpretability) **1주로 병합**, Privacy&Safety 별도 → RAI 3주→2주. 각 현재 주 **기본 4일 보장**(부족 시 복습·정리일 패딩). 5회차·복습일 카드 **현재 주차만**.

**세부:**
- 라벨: 코스별 `sl`(짧고 구분되는 이름)로 sec-chip·rail-phase·개요표 표기. 예) RAI: Fairness/Bias + Interpretability / RAI: Privacy & Safety.
- 구조: 과거 4 + 현재 17 = 21주(W-4~W-1 / W1~W17). RAI 병합으로 18→17.
- 5회차·복습일: 현재 주차에만(과거 제외). 작업별 시간배분·랩 링크(LINK.html, §9)·진행배지 유지.
- 검증: `node --check` OK, 21 섹션, fifth/review 각 17, /labs/ 149, Visitor(612209)·XAI(583401) 노출.

**미결:** 복습 패턴 A/B/C(현재는 A식 폴딩) + 시험대비 단계 추가 여부 → 결정 시 반영(현재 17주, 시험대비 추가 시 ~18~19주·11월).

**영향 파일:** `PMLE_18week_study_plan.html`(재빌드), `HISTORY.md`, `archive/…v17…`

**롤백:** v16/v14.

---

## 2026-06-16 (w) — Claude (AI 작업자) — 리포트: W16~18 배치 이유·복습패턴·시험대비 누락 (HTML 미변경)

**요약:** W16~18=Responsible AI 3종인 이유(path 17 마지막 3코스 순서) 설명. 옵션 B 재정렬로 **시험대비/모의고사 단계가 누락**된 점 지적. 복습 패턴(A/B/C) 미결 + 시험대비 추가 여부 결정 요청. 카드 범위=현재 주차만으로 확정(구현 시 반영).

**세부:**
- W16~18: 실제 path 17 끝 3코스(Fairness&Bias·Interpretability·Privacy&Safety)라 그 순서. 각 3~5h로 1주씩.
- 누락: 모의고사·약점보강·서비스 의사결정표(구 시험모드) + Study Guide(1171) 빠짐 → W18 이후 시험대비 2~3주 추가 권장(종료 11월 중순).
- 복습 패턴 A(세션 내 복습, 18주 유지) 권장 / B(별도 복습일, ~30주) / C(절충 ~22~24주). 결정 대기.
- 확정: 5회차·복습일 카드 현재 주차만.

**영향 파일:** `reports/2026-06-16_복습패턴-W16-18배치-검토.md`, `HISTORY.md` (HTML 미변경)

---

## 2026-06-16 (v) — Claude (AI 작업자) — 복습일·5회차 복원 + W18까지 18주 구성

**요약:** v15에서 누락된 **5회차(선택)·복습일(결원 시)·실습 복습** 카드를 코스 기반으로 재생성해 복원. 현재분을 **W1~W18(18주)**로 구성(목표 주차 합=18) → 마무리 ~10월 말.

**세부:**
- 회귀 수정: v15 전면 재빌드가 5회차/복습일 카드를 드롭함 → 각 주에 **5일차(선택·여유 시 심화/보충)** + **복습일(팀원 결석 시: 능동 회상·랩 재실행·퀴즈 재응시·teach-back)** 카드 재생성. 그 주 실제 랩(링크) 참조.
- 주차 구성: 코스별 목표 주차(Create ML 1·FE 4·Keras 3·Production 3·MLOps GS 1·Manage Features 1·GenAI+Eval 1·GenAI Apps 1·Fairness 1·Interpret 1·Privacy 1 = **18**)로 세션 균등 분배 → **과거 4 + 현재 18 = 22주**, 라벨 W-4~W-1 / W1~W18.
- 작업별 시간배분(시간칩·⏱합계·2h 상향)·랩 링크(LINK.html href, RULE §9)·진행배지 유지.
- 검증: `node --check` OK, 22 섹션, fifth/review 각 22, /labs/ 157, Visitor(612209) 노출.

**영향 파일:** `PMLE_18week_study_plan.html`(재빌드), `HISTORY.md`, `archive/…v16…`

**일정:** 현재 18주 → 종료 ≈ **2026-10-20**(빡빡)~10-27, +시험대비 → 11월 중순. 롤백 v15/v14.

---

## 2026-06-16 (u) — Claude (AI 작업자) — 구현: 작업별 시간배분 재구성(HTML)

**요약:** 계획서 v3대로 본문 전면 재구성. **일자마다 작업별 분(分) 배분 + ⏱합계 + 줄바꿈 가독성**, 무거운 코스 다주 분할, 실제 랩시간 반영(2h 랩 ⤴상향), 시간비례 페이싱.

**세부:**
- 구조: **과거 4주(완료) + 현재 15주 = 19주**(목표 ≤18~20 충족). 라벨 W-4~W-1 / W1~W15. 활성=현재 W1(Create ML Models).
- 일자 카드: `day-act` 줄글 → **`day-tasks` 리스트**(줄별 `[Nm]` 시간칩 + 아이콘 + 랩 하이퍼링크 + 상태배지) + `⏱ 합계` + 2h 랩 `⤴ 그날만 상향`. 헤더 day-time도 ⏱합계 표기.
- 페이싱: 세션 90m, 랩은 실제시간(Taxi/Bracketology 60·TF Dataset 120 등), 강의는 ×0.7 배속·조밀패킹, 복습/퀴즈 라인 폴딩, 잔여 1세션은 5회차로 흡수.
- 무거운 코스 분할: Feature Engineering·Keras·Production = 각 다주. 마이크로러닝(GenAI 개요+Model Evaluation) 1주 묶음.
- 랩 링크 LINK.html href 유지(RULE §9), 진행배지 LINK.html 기준. 드로어/진행/체크/툴바/linkify 유지(openMat PLAN_DATA 가드, lab-row 주입 제거, TOTAL_BASE=19*4).
- 검증: `node --check` OK, /labs/ 127, Visitor(612209)·TF Dataset(512769) 노출, 19 섹션.

**영향 파일:** `PMLE_18week_study_plan.html`(전면 재구성), `HISTORY.md`, `archive/…v15…`

**관련 보고서:** `reports/2026-06-16_구현-작업별시간배분-재구성.md`

**롤백:** 직전 구조 v14(`archive/…v14_lablink-durable.html`).

---

## 2026-06-16 (t) — Claude (AI 작업자) — 계획서 v3(작업별 시간배분 + 가독성)

**요약:** 일자(90m)별 **작업별 소요시간(분) 표시** + 줄바꿈 가독성 개편안 작성. 대표 랩 실제시간 확인(Taxi Fare 1h·Bracketology 1h·TF Dataset API 2h) + 표준 시간표. 워크드 예시(W1 Create ML Models 4일+5회차, 2h 상향/강의 배속 패턴). HTML 미변경.

**세부:**
- 표시형식: `[60m] 🧪 랩명 ✅` 줄단위 + `⏱ 합계 90m` + 2h 상향 `⤴`. 랩은 LINK.html href(§9).
- 작업 표준시간표(Qwik 45–60m·일반 60–90m·Challenge 90–120m·강의모듈 10–15m 배속·노트 15–25m·복습 25–40m·퀴즈 15–25m).
- 규칙: 2h+랩 그날 상향/2세션 분할, 강의 배속+복습 2:1, 무거운 코스 다주.
- 일정: 6일 손실 반영 18~19주, 종료 2026-10-20~10-27.

**영향 파일:** `reports/2026-06-16_재페이싱-계획서-v3-작업별시간배분.md`, `HISTORY.md` (HTML 미변경)

---

## 2026-06-16 (s) — Claude (AI 작업자) — 재페이싱 리포트 정정(6일 손실)

**요약:** "프로젝트로 바쁜 건 총 6일(=6세션)"로 정정(이전 '6주' 오기). 영향 미미(~1.5주분) → 추정 좁혀짐: 현재분 **18~19주**, 종료 **2026-10-20~10-27**(상한 11-03). 리포트 v2 갱신. HTML 미변경.

**영향 파일:** `reports/2026-06-16_재페이싱-리포트-v2-확정파라미터.md`(정정), `HISTORY.md`

---

## 2026-06-16 (r) — Claude (AI 작업자) — 재페이싱 리포트 v2(확정 파라미터, HTML 미변경)

**요약:** 사용자 확정 파라미터(1.5h 기본·긴랩 날만 상향·주4회+5회차·6주는 3회·최대 18주·강의 배속+복습2:1) 반영해 재페이싱 리포트 v2 작성. 종료일 추정 포함.

**세부:**
- 주 배정: Create ML Models 1 · FE 4 · Keras 3 · Production 3 · MLOps GS 1 · Manage Features 2 · GenAI묶음 1 · Model Eval 1 · GenAI Apps 1 · Fairness 1 · Interpret 1 · Privacy 1 → **현재분 ≈ 18~20 학습주**.
- 종료일(기준 06-16): 18주→**2026-10-20**, 20주→**2026-11-03**. 시험대비 2~3주 추가 시 11월 중순~말 응시 적기.
- 강의 배속(×0.7)+복습 2:1, 2h+랩은 분할/상향, 6주 3회 반영.
- 드로어 옛 시험자료 링크는 PLAN_DATA 재생성으로 정리 예정.

**영향 파일:** `reports/2026-06-16_재페이싱-리포트-v2-확정파라미터.md`, `HISTORY.md` (HTML 미변경)

---

## 2026-06-16 (q) — Claude (AI 작업자) — 실제 소요시간 기반 재페이싱 리포트(HTML 미변경)

**요약:** 랩/코스 실제 시간이 1.5h/일을 초과(예: TF Dataset API 2h)하는 문제 + 드로어 옛 시험자료 링크 깨짐. 웹으로 코스 pace 수집 후 재페이싱 리포트 제출(HTML은 미변경 — 사용자 파라미터 확정 대기).

**세부:**
- 코스 pace 웹 확인: Feature Engineering 24h · Keras 15.5h · Production ML 16h · Manage Features 8h · MLOps GS 4.5h · Model Eval 2.5h · GenAI Apps/Fairness 4h · Privacy 5h · Interpret 3h · 마이크로러닝(Intro GenAI 45m·LLMs 1h·MLOps GenAI 30m) 등.
- 계산: 현재(W1~) ≈ 94.5h → ⌈pace/1.5⌉ 세션 합 ≈ 68세션 ≈ **17주**(주4회). 무거운 코스(FE 4주·Keras/Production 2.75주)는 여러 주 필요. 2h 랩은 세션 분할.
- 드로어 링크 깨짐 원인=옵션 B 후 PLAN_DATA가 옛 시험모드 자료 잔존 → 재계획 시 PLAN_DATA를 코스 기준 재생성(실제 랩 href만, 무의미 google-search 제거).
- 확인 요청: 일 학습시간(1.5h?), 2h+랩 처리, 주 4회 여부, 현재분 ~17주 수용 여부.

**영향 파일:** `reports/2026-06-16_실제소요시간-기반-재페이싱-리포트.md`, `HISTORY.md` (HTML 미변경)

---

## 2026-06-16 (p) — Claude (AI 작업자) — 실습 링크 복구 + 영속화 + RULE §9

**요약:** 실습 하이퍼링크가 또 깨진 건을 LINK.html에서 재추출해 복구하고, **lab 제목을 linkify 대상으로 등록**해 본문·칩 모두 영구 링크되게 함. RULE §9(실습 링크 영속성) 신설.

**세부:**
- 진단: DAY_ASSIGN/ACTUAL_LABS 데이터는 살아있었으나, day-act **본문의 랩 이름이 비링크 텍스트**라 "깨진" 것으로 인지됨.
- 복구: `LINK.html`에서 lab 43개 재추출 → `DAY_ASSIGN`/`ACTUAL_LABS` 재생성(정확 href). 
- 영속화: load 시 모든 lab 제목을 `LINK_MAP`에 추가하고 `LINK_RE` 재생성하는 IIFE 주입 → `linkify`가 본문·드로어·칩 어디서든 lab 제목을 해당 href로 링크. 재라벨/재구성에도 데이터 무손상.
- RULE **§9 신설**: 단일출처 LINK.html, 저장위치 DAY_ASSIGN/ACTUAL_LABS, lab 제목 linkify 등록, 재구성 시 재추출, 변경 후 검증 체크리스트(`/labs/` 개수·대표 href·`node --check`).
- 검증: `node --check` OK, /labs/ 87 유지, Visitor Purchases·ML APIs·Keras·Privacy href 확인.

**영향 파일:** `PMLE_18week_study_plan.html`, `RULE.md`(§9), `HISTORY.md`, `archive/…v14…`

---

## 2026-06-16 (o) — Claude (AI 작업자) — 과거주차 시프트 + 노트북 코스 리서치

**요약:** 완료 코스를 과거주차(W-4~W-1, 완료처리)로 시프트하고 Create ML Models를 현재 W1로 라벨 재배치. 노트북 코스 접속 리서치 + 페이싱 답변.

**세부:**
- 표시 라벨 시프트: 내부 w1~w4 → **W-4~W-1(과거·완료·복습용)**, w5(Create ML Models) → **현재 W1**, … w18 → W14. 내부 id/데이터 무변경(안전). 활성 패널 w5로, 과거 4주 INITIAL_PROGRESS 100% 체크. 레일에 "이전/현재" 구분선.
- #1 페이싱 답: 현실 페이싱(세션≈랩1개)이면 18주 고정 불가 — 랩 42개≈10.5주 + 마이크로러닝/리뷰 → 현재분 대략 16~20주. "1코스=1주" 고정 비현실적, 코스 단위로 봐야.
- #2 리서치: 923 Working with Notebooks **폐기 아님**(skills.google·partner·Coursera·Class Central 등재). skills.google는 비로그인 홈 리다이렉트(로그인/리브랜딩 점검), Coursera는 유료. 대안: 로그인 후 path17 / Coursera Plus / 공식 docs·Workbench Qwik Start로 동등 학습.
- 검증: `node --check` OK, 라벨·활성패널·진행 확인.

**영향 파일:** `PMLE_18week_study_plan.html`, `HISTORY.md`, `archive/…v13…`

**관련 보고서:** `reports/2026-06-16_과거주차-현재시프트-및-노트북코스-리서치.md`

---

## 2026-06-16 (n) — Claude (AI 작업자) — 옵션 B 재정렬

**요약:** 플랜 18주를 **실제 path 17 코스 순서로 재정렬**(LINK.html 기준). 코스의 모든 실제 랩을 주차 일자(d1/d3)에 **분배**해 빠지는 랩 없음("Predict Visitor Purchases" 포함).

**세부:**
- 주차→코스 1:1 재매핑(path 순서): W1 Intro AI/ML · W2 Prepare Data for ML APIs(완료) · W3 Working with Notebooks · W4 Engineer Data(BQML) · W5 Create ML Models(BQML) · W6 Feature Engineering · W7 Keras · W8 Production ML · W9 MLOps Getting Started · W10 Manage Features · W11 Intro GenAI · W12 Intro LLMs · W13 MLOps for GenAI · W14 Model Evaluation · W15 Create GenAI Apps · W16 Fairness&Bias · W17 Interpretability · W18 Privacy&Safety.
- 각 주: wk-theme/sec-chip/phase/진행배지 갱신, 일자 focus·activity·산출물을 코스 랩 기반으로 재작성(grounded). 개요표도 코스·진행·랩수로 재생성.
- `DAY_ASSIGN`(주차→d1/d3 랩 분배) 신설, `labRowHTML`/`daySection`이 이를 사용(퍼지매칭 폐기). 모든 랩이 일자에 빠짐없이 노출, d1≠d3.
- 퀴즈(PLAN_DATA)는 주차 번호 기준 일반 ML 복습 퀴즈로 유지. 검증: `node --check` OK, 랩 분배·Visitor Purchases 노출 확인.

**영향 파일:** `PMLE_18week_study_plan.html`(대규모 재구성), `HISTORY.md`, `archive/…v12…` (RULE §2-5 갱신)

**관련 보고서:** `reports/2026-06-16_옵션B-실제경로-재정렬.md`

**롤백:** 이전 구조는 `archive/…v11_dayspecific-labs.html`.

---

## 2026-06-16 (m) — Claude (AI 작업자)

**요약:** 1·3일차 랩 중복 버그 수정(주 단위 dump → **일자별 매칭**) + 워크로드·구조 점검 보고.

**세부:**
- `dayMatchedLabs`/`chunkMatch` 추가: 그 일자 [Lab] 활동과 매칭되는 랩만 일자별로 연결([Lab] 구간 고유단어 50%+ & 길이≥5). 오매칭(Visitor↔Taxi) 제거, d1≠d3.
- 카드/드로어가 주 전체를 매일 뿌리지 않고 일자 매칭 랩 + 코스 링크 + "주중 분산" 안내로 변경.
- 점검: 총량 108h는 무리 아님(코스 랩은 주중 분산). 단 **플랜 일자 테마 vs 실제 코스 주제 불일치**(W3 AutoML↔ML APIs 등) 발견 → 옵션 B(실제 코스 순서 재정렬) 권장, 확인 후 진행.
- 검증: `node --check` OK, 일자매칭 시뮬레이션 확인.

**영향 파일:** `PMLE_18week_study_plan.html`, `HISTORY.md`, `archive/…v11…`

**관련 보고서:** `reports/2026-06-16_일자별랩-수정-및-스케줄점검.md`

---

## 2026-06-16 (l) — Claude (AI 작업자)

**요약:** LINK.html의 **실제 실습 랩 42개를 정확한 href로** 플랜에 하이퍼링크(주차별 배치). 직전 작업은 lab을 7개만 잡았으나(strict 파싱 누락) 재파싱으로 전수 반영.

**세부:**
- LINK.html 임베드 JSON에서 `/labs/<id>` 활동 전수 추출(course_templates + course_sessions): 42개 고유 lab(제목·href·완료상태). 세션↔코스↔주차 매핑으로 배치.
- `ACTUAL_LABS` 교체: W1(4)·W2(8)·W3(9 전부 완료)·W4(2)·W5(1)·W7(3)·W8(5)·W10(5)·W12(1)·W14(3)·W15(1). 각 lab은 LINK.html의 정확한 href로 링크 + 진행도 배지.
- 드로어 "🧪 실제 실습 랩(LINK.html)" 섹션 + 실습일 카드 칩이 실제 lab으로 연결. 코스 링크·path 앵커 유지.
- 검증: `node --check` OK, 주요 href(ML APIs·Keras·Production·BQML) 임베드 확인. 임시 스크립트 정리.

**영향 파일:** `PMLE_18week_study_plan.html`, `HISTORY.md`, `archive/…v10…`

**관련 보고서:** `reports/2026-06-16_LINK-실습랩-전수반영.md`

**참고:** 미등록 코스(W6·9·11·13·16~18 등)는 LINK.html에 lab 활동이 펼쳐져 있지 않아 lab href 없음 → 코스/path 링크 유지.

---

## 2026-06-15 (k) — Claude (AI 작업자)

**요약:** `LINK.html`(사용자 실제 path 17 수강 페이지)에서 **실제 커리큘럼·진행도·링크**를 파싱해 플랜에 반영.

**세부:**
- LINK.html 임베드 JSON(`isComplete`/`inProgress`)에서 진행도 추출: **완료** Prepare Data for ML APIs / **진행중** Intro to AI&ML·Create ML Models with BigQuery ML·Feature Engineering / 나머지 미시작.
- 실제 16코스(앵커로 id↔title 확인) 중 **WebFetch 익명 로드 검증** 통과분만 사용. 923(Working with Notebooks)·191·684는 미로드 → 제외.
- `WEEK_COURSE`를 실제 커리큘럼으로 교체(627·584·1120·1080·539·927·1036·989·631·593·11·12·17·158·1171). 각 주차에 **진행도 배지**(✅완료/⏳진행중/⬜시작전) 표시(`cstat()`). 사용자 체크박스(localStorage)는 건드리지 않음(비파괴).
- 생성형 AI 중심 커리큘럼 반영(Intro GenAI/LLMs·Create GenAI Apps·MLOps for GenAI·Model Evaluation·Responsible AI 3종).
- 검증: `node --check` OK, 924 미사용 확인.

**영향 파일:** `PMLE_18week_study_plan.html`, `HISTORY.md`, `archive/…v9…` (RULE §2-5 갱신)

**관련 보고서:** `reports/2026-06-15_실제경로-진행도-반영.md`

---

## 2026-06-15 (j) — Claude (AI 작업자)

**요약:** 사용자의 "2026 개편 가중치(생성형 AI↑)" 분석에 대한 평가 보고서 작성(플랜 변경은 미적용 — 확인 대기).

**세부:**
- 공식 6도메인(13/16/21/20/18/13) 재확인. 생성형 AI·Model Garden·파인튜닝·평가·Model Armor는 **별도 도메인 아님 → Section 1·3·4에 분산** 확인. 캐시 PDF의 구버전 구조(25/20/20/20/10/5)는 부정확으로 배제.
- 평가: 방향(생성형 AI 비중↑, Keras 비정점, 서비스선택 훈련) 동의 / "신규 25~30% 별도 블록"은 공식 가중치 아닌 학습전략 — W5~W13(Section 3·4=41%) 삭감 대신 **업그레이드·통합** 권고.
- 보고서에 108h 재조정안 제시(적용은 사용자 confirm 후).

**영향 파일:** `reports/2026-06-15_커리큘럼-가중치-재검토.md`, `HISTORY.md` (플랜 HTML 미변경)

---

## 2026-06-15 (i) — Claude (AI 작업자)

**요약:** 링크를 **실제 익명 로드 검증(WebFetch)** 후 동작하는 것으로 교체. "시작부터 안 열림"의 진짜 원인(focus 딥링크가 비로그인 시 홈 리다이렉트)을 확인하고, 검증된 path 17 코스 링크로 전환.

**세부 변경(검증 기반):**
- WebFetch 검증: `skills.google/focuses/<id>` → 비로그인 시 홈 리다이렉트(안 열림). `…/labs/<id>` → 로그인 페이지. `skills.google/paths/17` 및 `…/course_templates/{593,11,12,17,158,985,1171}` → **익명 로드 OK**. 191·684 → 미로드(사용 안 함).
- 제목 오류 교정: focus 581 = "AI Platform: Qwik Start"(기존 "Vertex AI Platform…" → 검색 0건 원인).
- `WEEK_COURSE`(주차→검증 코스) 신설, 모든 랩 링크를 **해당 코스 페이지**로 연결 + path 17 앵커/로그인 안내. 개별 랩명은 "이 코스에서 수행할 랩"으로 텍스트 표기.
- RULE §2-5 전면 갱신(검증 안 된 링크 금지). 검증: `node --check` OK.

**영향 파일:** `PMLE_18week_study_plan.html`, `RULE.md`(§2-5), `HISTORY.md`, `archive/…v8…`

**정직 고지:** 로그인 뒤 개별 랩은 자동 클릭검증 불가 → 검증된 코스/경로(익명 로드 확인) 링크로 연결하는 방식을 채택. 더 이상 추측 링크를 넣지 않음.

---

## 2026-06-15 (h) — Claude (AI 작업자)

**요약:** 카탈로그 검색 링크가 옛 제목 불일치로 ‘결과 0개’ → **직접 링크 복원 + 공식 경로(path 17) 앵커 + 제목 교정**으로 수정.

**세부 변경:**
- 웹 검증: 공식 PMLE 경로 **`https://www.skills.google/paths/17`**(오늘자 유효). “Vertex AI: Qwik Start”의 실제 경로 내부 링크 `/paths/17/course_templates/684/labs/521515` 확인.
- 제목 오류 교정: focus 581 = **“AI Platform: Qwik Start”**(기존 “Vertex AI Platform…”은 미존재 → 검색 0건 원인).
- 링크를 카탈로그 검색 → **skills.google 직접 경로(`u`, /focuses/<id> 및 path 내부)** 로 복원. 모든 랩 드로어에 **공식 경로(path 17) 앵커 + 로그인 안내**(`pathLine()`) 노출.
- 정직 고지: 로그인 뒤의 개별 랩은 자동 클릭검증 불가 → UI/응답에 한계 명시, path 17을 권위 출처로 안내.
- RULE §2-5 갱신. 검증: `node --check` OK, 직접 링크 25개·path 앵커 반영.

**영향 파일:** `PMLE_18week_study_plan.html`, `RULE.md`(§2-5), `HISTORY.md`, `archive/…v7…`

---

## 2026-06-15 (g) — Claude (AI 작업자)

**요약:** 랩 링크의 **QL401(access denied) 오류 수정** + **1·3일차 동일 링크 문제 수정**.

**세부 변경:**
- **QL401 원인 제거:** `…/focuses/<id>?parent=catalog` 직접 딥링크(로그인/카탈로그 컨텍스트 없으면 접근거부)를 클릭 대상에서 제거. 클릭은 **공개 카탈로그 검색**(`skills.google/catalog?keywords=<제목>`)으로 연결(오류 없음). focus/path ID는 참고 텍스트로만 표기. 산출물 내 `/focuses/` href 0개 확인.
- **일차별 분리:** 주 단위 `LAB_LINKS` → **`DAY_LABS`(`"<주>-<일>"` 키)**로 재구성. 같은 주라도 1·3일차가 서로 다른 랩을 가리킴(예: W1 d1=Vertex AI/Platform Qwik Start, d3=Interactive Data Exploration).
- 드로어: 일차 드로어 “✅ 이 일차 실습 랩”, 5회차/복습일 “🧪 이 주의 실습 랩(참고)”.
- RULE §2-5 갱신. 검증: `node --check` OK, focus 딥링크 href 0개.

**영향 파일:** `PMLE_18week_study_plan.html`, `RULE.md`(§2-5), `HISTORY.md`, `archive/…v6…`

**보류 결정:** 사용자가 검증한 focus 딥링크를 직접 href로 쓰면 QL401이 재발하므로, 안정적 검색 링크를 기본으로 채택(원하면 직접 링크로 되돌릴 수 있음 — 단 로그인 세션 필요).

---

## 2026-06-15 (f) — Claude (AI 작업자)

**요약:** 사용자가 직접 열람·검증한 **실제 Skills Boost 딥링크**(skills.google, focus ID 포함)를 HTML에 반영. 검색 링크 → 검증된 직접 링크로 교체.

**세부 변경:**
- `LAB_LINKS`(주차별 검증 랩, 25개 항목/26 focus 참조) + `labURL()`/`weekLabsSection()` 추가. 도메인 `https://www.skills.google` 통일(잔존 cloudskillsboost 0건).
- 카드: 그 주 검증 랩 칩(최대 3 + “자료 보기”). 드로어: “✅ 이 주의 실습 랩 (검증됨)” 전체 목록.
- **폐기 2개 제외:** Vertex AI Tabular Data Qwik Start(43565, 홈 리다이렉트), Mitigate Bias with MinDiff(87247). → Responsible AI: Fairness & Bias 코스(985) + Explainable AI 랩(87289)로 대체 반영.
- 봇차단 자동확인 보류분(1162·25097·21026·1163·21599)은 `s:"blocked"` 배지로 표기하되 링크 유지.
- RULE §2-5 갱신. 검증: `node --check` OK, 폐기 ID 미포함 확인.

**영향 파일:** `PMLE_18week_study_plan.html`, `RULE.md`(§2-5), `HISTORY.md`, `archive/…v5…`

**관련 보고서:** `reports/2026-06-15_검증된-실습랩-링크-반영.md`

**참고:** Excel(`PMLE_18week_plan.xlsx`)은 본인이 만든 산출물이 아니어서 미수정(요청 시 구조 확인 후 반영).

---

## 2026-06-15 (e) — Claude (AI 작업자)

**요약:** 프로젝트 개선 3건 실행 — (P3) 루트 `.gitignore` 신설 + 비밀정보 점검, (P5) 폴더/파일명 정리(이력 보존), (P6) 진행상태 단일 HTML 이식(저장/공유).

**세부 변경:**
- **P3:** 자격증명 노출 점검 0건. 루트 `.gitignore` 추가(자격증명·`__pycache__`·임시파일 등). 일반 `*.json`(BQ 출력)은 추적 유지.
- **P5:** 코스 폴더 12개 + `0000_PLAN` 내부 파일 4개를 ASCII kebab/영문으로 rename. 추적분은 `git mv`로 169파일 이력 보존. 매핑은 보고서 참조. RULE §8.2 신설.
- **P6:** 헤더 툴바(💾 진행상태 포함 저장 HTML / 📤 내보내기·📥 가져오기 JSON / ↺ 초기화) + 파일 내장 `INITIAL_PROGRESS` 병합 + 재오픈 멱등성. RULE §3-4 신설.
- 산출물 rename: `PMLE_18주_학습플랜.html` → `PMLE_18week_study_plan.html` 등. archive v4 적재.
- 검증: `.gitignore` check-ignore OK, git rename 169 OK, `node --check` OK, self-save 라운드트립 OK.

**영향 파일:** `.gitignore`(루트 신규), 코스 폴더 12개·`0000_PLAN` 파일 4개(rename), `PMLE_18week_study_plan.html`, `RULE.md`(§3-4·§8), `HISTORY.md`, `archive/…v4…`

**관련 보고서:** `reports/2026-06-15_보안-네이밍-진행이식.md`

---

## 2026-06-15 (d) — Claude (AI 작업자)

**요약:** 산출물 HTML **버전 백업 체계 도입**. `archive/` 폴더 생성 후 현재 버전 스냅샷 적재, RULE에 버전 백업 규칙(§0.1) 추가.

**세부 변경:**
- `archive/PMLE_18week_study_plan__2026-06-15_v3_lab-links.html` 적재(현재 상태 = v3).
- **솔직 고지:** 이전 v1(초기 빌드)·v2(하이퍼링크) 중간본은 제자리 Edit로 덮어써져 **별도 스냅샷이 없어 복구 불가**. 원본 `.mhtml`(v0)만 보존됨. 본 시점부터 변경 전 스냅샷을 남김.
- RULE.md §0.1 신설(변경 전 `archive/`에 `__YYYY-MM-DD_vN_요약.html`로 백업, archive 읽기전용).

**영향 파일:** `archive/`(신규), `RULE.md`(§0.1), `HISTORY.md`

---

## 2026-06-15 (c) — Claude (AI 작업자)

**요약:** `실습`(hands-on) 타입 일자에 **해당 실습 랩 링크를 카드에 직접 노출**(🧪 실습 랩 열기). 명시 랩명 없으면 토픽 기반 Skills Boost 검색 링크(🔎 관련 실습 랩 찾기).

**세부 변경:**
- `labRowHTML()` + `skillsUrl()` 추가, 로드 시 모든 `실습` 카드에 랩 링크 행 주입, 일간 자료 드로어 상단에도 동일 노출.
- 실습 30일 중 13일 명시 Lab 직접 링크 / 17일 토픽 검색 폴백(존재하지 않는 랩 미생성 — 정직 처리).
- 5회차·복습일 카드는 영향 없음(타입이 `실습` 아님).
- RULE.md §2-5 신설. 검증: `node --check` 통과.
- 프로젝트 전반 개선 제안 보고서 별도 작성.

**영향 파일:** `PMLE_18week_study_plan.html`, `RULE.md`, `HISTORY.md`

**관련 보고서:** `reports/2026-06-15_실습랩-직접링크-보고서.md`, `reports/2026-06-15_프로젝트-개선-제안.md`

---

## 2026-06-15 (b) — Claude (AI 작업자)

**요약:** 일간 활동·학습 카드·자료의 제품/콘솔/랩 용어를 **실제 작업 공간으로 가는 하이퍼링크**로 전환. 클릭하면 콘솔·Skills Boost 실습 랩·공식 문서로 바로 이동.

**세부 변경:**
- URL 형식 웹 검증: Skills Boost 검색(`cloudskillsboost.google/catalog?keywords=`), Agent Platform 공식 문서 도메인(`docs.cloud.google.com/gemini-enterprise-agent-platform/...`).
- HTML에 `LINKS` 매핑(40+ 용어) + `linkify()`/`resLink()`/`quickLinks()` 추가.
  - 본문(`.day-act`, `.wk-theme`)과 드로어(학습 카드·자료)의 용어 자동 하이퍼링크.
  - 드로어 상단 "🚀 작업 공간·바로가기" 칩 + 작업 방법 안내 노트.
  - 자료: `Lab:` → Skills Boost 검색, `Doc:`/기타 → 제품 콘솔 링크 + 🔎 공식 문서 검색.
- 불확실 deep-link은 지어내지 않고 안정 콘솔 경로/문서 검색으로 연결, 리다이렉트 가능성 UI 명시(RULE §1·§2-4).
- 검증: `node --check` 통과, 링크 매핑 40개·드로어 연결 확인.

**영향 파일:** `PMLE_18week_study_plan.html`(CSS+JS 추가), `RULE.md`(§2-4 신설), `HISTORY.md`

**관련 보고서:** `reports/2026-06-15_실습-하이퍼링크-추가-보고서.md`

---

## 2026-06-15 — Claude (AI 작업자)

**요약:** 원본 MHTML 스냅샷을 기반으로 새 standalone 인터랙티브 HTML 학습 플랜을 제작. 진행률 체크 기능, 일간 학습자료/퀴즈, 5회차(선택)·복습일, 영어 도메인명 표기를 추가.

**세부 변경:**
- 원본 `.mhtml` 디코딩 → 18주 × 4일 구조 전체 파악(원본은 JS 없는 정적 스냅샷).
- 핵심 사실 웹 검증: Vertex AI → **Gemini Enterprise Agent Platform** 리브랜딩(Cloud Next '26, 2026-04-22), PMLE 2026 공식 6개 도메인·비중.
- 18주 전체 **학습 카드 + 주간 퀴즈(5문항) + 5회차(선택) + 복습일** 자료 생성·구조 검증(18주/4일/5퀴즈/4선택지) 후 HTML 내 `PLAN_DATA`로 임베드(단일 원천). 불확실 사실은 `(확인필요)`·`verify:true`로 태그(확인필요 카드 27 + 퀴즈 1).
- 새 HTML `PMLE_18week_study_plan.html` 생성:
  - 좌측 레일 탭 전환 JS(원본은 동작 안 함) 구현.
  - **도메인명 영어 표기**로 통일(Section 1~6 공식 영문명).
  - **일간 체크박스 + localStorage 저장**, 주 기본 4일 완료 시 주간 완료 배지.
  - 스펙트럼 막대 아래 **전체 진행률 막대** 추가.
  - 일간 카드 **"학습 자료" 드로어**(학습 카드·퀴즈·리소스) 추가.
  - 각 주에 **5회차(선택) 카드 + 복습일 카드** 추가.
- 규칙·이력 문서화: `RULE.md`, `HISTORY.md`, `reports/` 폴더 생성.

**영향 파일:** `PMLE_18week_study_plan.html`(신규, 데이터 임베드 = 단일 원천), `RULE.md`(신규), `HISTORY.md`(신규), `reports/`(신규). 빌드용 중간 파일(`_`)은 작업 후 정리.

**관련 보고서:** `reports/2026-06-15_UI-변경-및-제작-보고서.md`

**원본 보존:** `PMLE_18week_plan_source.mhtml`은 수정하지 않음(백업).
