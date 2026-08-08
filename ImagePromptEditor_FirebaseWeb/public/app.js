const data = {
  image: {
    modes: ["", "文生圖模式", "圖生圖模式", "修改/置換圖片模式", "圖生文模式", "提示詞優化模式"],
    platforms: ["", "通用", "ChatGPT", "Midjourney", "SDXL", "Flux", "DALL·E"],
    fields: [
      ["subject", "1. 主體", ["", "高質感人物肖像", "商業產品主體", "電影感角色設計", "品牌形象主視覺", "美食商品特寫", "室內空間設計", "自然風景主題", "科技裝置或未來產品", "電商主圖商品", "高端保養品瓶身", "時尚服裝模特兒", "精品配件", "交通工具", "寵物或動物角色"]],
      ["scene", "2. 場景", ["", "城市夜景街道", "高級攝影棚", "自然森林", "海邊日落", "現代辦公室", "精品展示櫃", "科幻實驗室", "居家生活空間", "戶外旅遊場景", "極簡純色背景", "未來城市", "咖啡廳", "商場櫥窗"]],
      ["action", "3. 動作", ["", "站立凝視鏡頭", "行走中", "使用產品", "展示商品細節", "回眸", "跳躍動作", "拿起物件", "互動交談", "正在烹飪", "駕駛或移動", "風中飄動", "產品旋轉展示"]],
      ["composition", "4. 構圖", ["", "置中主體", "三分法構圖", "對稱構圖", "留白構圖", "前景遮擋", "近景特寫", "全身構圖", "低角度英雄視角", "俯視構圖", "廣角環境構圖", "微距細節構圖"]],
      ["camera", "5. 鏡頭", ["", "50mm 標準鏡頭", "85mm 人像鏡頭", "24mm 廣角鏡頭", "微距鏡頭", "長焦壓縮感", "淺景深", "深景深", "電影鏡頭語言", "產品攝影鏡頭", "手機攝影視角"]],
      ["light", "6. 光線", ["", "柔和自然光", "黃金時刻光線", "棚拍柔光箱", "逆光輪廓光", "霓虹光", "低調戲劇光", "高調明亮光", "窗邊側光", "電影感硬光", "體積光", "產品反射控制光"]],
      ["material", "7. 材質", ["", "皮膚質感自然", "金屬反射", "玻璃透明", "柔軟布料", "皮革質感", "木質紋理", "陶瓷光澤", "塑膠霧面", "液體光澤", "保養品瓶身反光", "精品鍍金細節"]],
      ["color", "8. 色彩", ["", "自然膚色", "黑白高反差", "暖色調", "冷色調", "高飽和色彩", "低飽和高級感", "品牌色主導", "粉色柔和調", "金色奢華感", "藍綠科技感", "電影色彩分級"]],
      ["style", "9. 風格", ["", "寫實攝影", "電影感", "高級商業攝影", "日系清新", "韓系時尚", "歐美雜誌風", "未來科技風", "極簡設計", "奢華精品風", "可愛插畫風", "3D 渲染", "動畫電影風"]],
      ["useCase", "10. 用途", ["", "電商商品主圖", "社群貼文", "廣告 Banner", "海報主視覺", "品牌形象圖", "簡報封面", "網站首頁視覺", "產品包裝視覺", "YouTube 縮圖", "短影音封面", "教學教材圖"]],
      ["ratio", "11. 比例", ["", "1:1 方形", "4:5 Instagram 貼文", "9:16 手機直式", "16:9 橫式", "3:2 攝影比例", "2:3 直式海報", "21:9 電影寬螢幕"]]
    ]
  },
  video: {
    modes: ["", "文生影片模式", "圖生影片模式", "修改/置換影片模式", "影片分鏡提示詞", "提示詞優化模式"],
    platforms: ["", "通用", "Runway", "Pika", "Kling", "Luma", "Veo", "Sora"],
    fields: [
      ["subject", "1. 主體", ["", "人物主角", "商品主體", "服裝模特兒", "保養品瓶身", "交通工具", "精品配件", "品牌吉祥物", "科幻角色", "美食主體", "室內空間"]],
      ["scene", "2. 場景", ["", "城市夜景", "攝影棚", "自然森林", "海邊", "未來城市", "現代辦公室", "精品展示空間", "居家生活場景", "戰術任務場景", "教育訓練場景"]],
      ["action", "3. 動作", ["", "慢速推進展示", "人物走向鏡頭", "商品旋轉", "換景轉場", "局部細節特寫", "快速運動", "鏡頭環繞", "從遠景進入近景", "開場到收尾完整動作"]],
      ["story", "4. 劇情/事件", ["", "開場建立場景", "發展展示主體", "高潮強調關鍵動作", "收尾品牌定格", "問題到解決", "產品使用流程", "前後對比", "任務鎖定到完成"]],
      ["cameraMotion", "5. 鏡頭運動", ["", "固定鏡頭", "慢速推鏡", "拉遠鏡頭", "橫向滑軌", "手持跟拍", "空拍俯衝", "環繞運鏡", "低角度跟拍", "微距推進"]],
      ["composition", "6. 構圖", ["", "置中構圖", "三分法", "對稱構圖", "前景到背景層次", "主體留白", "電影寬螢幕構圖", "動態引導線", "特寫到全景"]],
      ["light", "7. 光線", ["", "自然柔光", "電影低調光", "高級棚拍光", "霓虹夜景", "逆光輪廓", "黃金時刻", "科技冷光", "產品高光控制"]],
      ["material", "8. 材質/質感", ["", "寫實皮膚", "金屬反光", "玻璃透明", "布料細節", "液體流動", "塑膠霧面", "木紋自然", "精品鍍金", "高解析產品紋理"]],
      ["color", "9. 色彩", ["", "自然色彩", "電影調色", "暖色氛圍", "冷色科技", "高級低飽和", "品牌色", "高對比", "黑金精品", "藍綠未來感"]],
      ["style", "10. 風格", ["", "寫實影片", "電影廣告", "高級商品片", "社群短影音", "紀錄片風", "科幻未來", "教育訓練", "精品形象", "動畫電影感"]],
      ["useCase", "11. 影片用途", ["", "社群短影音", "產品廣告", "品牌形象片", "教學影片", "電商展示", "YouTube 片頭", "簡報影片", "活動宣傳", "訓練模擬"]],
      ["ratio", "12. 比例", ["", "16:9 橫式主流", "9:16 手機短影音", "1:1 方形", "4:5 社群直式", "21:9 電影寬螢幕"]],
      ["duration", "13. 時長", ["", "5 秒", "8 秒", "10 秒", "15 秒", "30 秒", "60 秒"]],
      ["pace", "14. 節奏", ["", "慢速高級感", "中速清楚展示", "快速社群節奏", "電影張力節奏", "平穩教學節奏"]],
      ["storyboard", "15. 分鏡 / 參考圖數量", ["", "無分鏡，單一連續鏡頭", "1 張參考圖：單鏡頭延伸", "2 張參考圖：起點 / 終點", "3 張參考圖：開場 / 發展 / 收尾", "4 張參考圖：開場 / 發展 / 高潮 / 收尾", "5 張參考圖：開場 / 建立 / 發展 / 高潮 / 收尾", "6 張參考圖：開場 / 建立 / 發展 / 轉折 / 高潮 / 收尾"]]
    ],
    tech: [
      ["resolution", "解析度", ["", "1920x1080 (1080p)", "3840x2160 (4K UHD)", "2560x1440 (2K/QHD)", "4096x2160 (DCI 4K)"]],
      ["frameRate", "影格率", ["", "24fps 電影感", "30fps 網路標準", "60fps 高動態", "23.98fps 專業影視"]],
      ["codec", "編碼格式", ["", "H.264 / MP4", "H.265 HEVC / MP4", "ProRes 422 HQ / MOV", "DNxHR / MXF"]],
      ["bitrate", "位元率", ["", "1080p 10-20 Mbps", "4K 35-68 Mbps", "高品質 VBR", "平台自動最佳化"]],
      ["colorSpace", "色彩空間", ["", "Rec.709", "Rec.2020", "HDR 交付參考", "標準 SDR"]]
    ],
    review: ["畫面穩定", "時間一致性", "角色不變形", "主體一致性", "鏡頭運動平滑", "景深與透視合理", "分鏡色彩一致", "HUD/UI 清楚可讀", "避免 flicker", "避免 artifacts", "保留字幕安全區", "敘事曲線完整"],
    audio: [
      ["audioMode", "聲音模式", ["", "無聲，僅輸出畫面提示詞", "背景音樂", "環境音", "旁白", "對白", "音樂 + 環境音", "音樂 + 環境音 + 旁白", "完整聲音設計"]],
      ["voiceover", "旁白", ["", "無旁白", "中文旁白", "英文旁白", "中英雙語旁白", "溫柔女聲", "專業男聲", "電影預告旁白", "教學說明旁白", "品牌形象旁白"]],
      ["dialogue", "對白", ["", "無對白", "自然生活對白", "產品介紹對白", "角色短句互動", "旁白式獨白", "訪談式對話", "中英雙語對白", "保留口型同步空間"]],
      ["music", "音樂風格", ["", "無音樂", "電影配樂", "科技感電子音樂", "溫暖鋼琴", "緊張懸疑", "輕快社群短影音", "史詩管弦樂", "Lo-fi 輕音樂", "高級品牌氛圍音樂"]],
      ["ambience", "環境音", ["", "無環境音", "城市街道聲", "海浪聲", "風聲", "雨聲", "室內空間混響", "機械運作聲", "人群背景聲", "自然森林聲", "展場環境聲"]],
      ["sfx", "音效", ["", "無音效", "轉場音效", "UI 點擊音", "產品亮相音效", "爆發/衝擊音效", "柔和提示音", "科技掃描音", "鏡頭推進低頻音"]]
    ],
    mix: ["旁白清楚優先", "音樂不蓋過旁白", "環境音自然低音量", "整體音量平衡", "適合社群平台播放", "電影感寬動態混音", "人聲、音樂、環境音三者分層清楚", "低頻不混濁", "高頻不刺耳"]
  },
  quality: ["高解析度", "高細節", "主體清楚", "專業光線", "乾淨畫面", "質感自然", "色彩協調", "構圖平衡", "商業級品質", "可直接交付"],
  negative: ["文字與浮水印", "Logo 或品牌誤植", "臉部變形", "手指錯誤", "多餘肢體", "低解析", "模糊", "雜訊", "過曝", "欠曝", "構圖混亂", "不自然比例", "AI artifacts"]
};

const state = { tab: "image" };
const el = {
  tabs: document.querySelectorAll(".tab"),
  mode: document.getElementById("mode"),
  platform: document.getElementById("platform"),
  dynamicFields: document.getElementById("dynamicFields"),
  techFields: document.getElementById("techFields"),
  reviewFields: document.getElementById("reviewFields"),
  audioFields: document.getElementById("audioFields"),
  audioMixFields: document.getElementById("audioMixFields"),
  qualityFields: document.getElementById("qualityFields"),
  negativeFields: document.getElementById("negativeFields"),
  output: document.getElementById("output"),
  status: document.getElementById("statusText")
};

function fillSelect(select, items) {
  select.innerHTML = "";
  for (const item of items) {
    const option = document.createElement("option");
    option.value = item;
    option.textContent = item;
    select.append(option);
  }
  select.value = "";
}

function makeSelectField(key, label, items) {
  const wrap = document.createElement("label");
  wrap.innerHTML = `<span>${label}</span>`;
  const select = document.createElement("select");
  select.dataset.key = key;
  fillSelect(select, items);
  wrap.append(select);
  return wrap;
}

function makeCheckbox(name, text, checked = false) {
  const label = document.createElement("label");
  label.className = "check-item";
  const input = document.createElement("input");
  input.type = "checkbox";
  input.name = name;
  input.value = text;
  input.checked = checked;
  label.append(input, document.createTextNode(text));
  return label;
}

function selectedMap(container) {
  return Object.fromEntries([...container.querySelectorAll("select")].map(select => [select.dataset.key, select.value]));
}

function checkedValues(name) {
  return [...document.querySelectorAll(`input[name="${name}"]:checked`)].map(input => input.value);
}

function render() {
  const cfg = data[state.tab];
  fillSelect(el.mode, cfg.modes);
  fillSelect(el.platform, cfg.platforms);

  el.dynamicFields.innerHTML = "";
  cfg.fields.forEach(field => el.dynamicFields.append(makeSelectField(...field)));

  el.techFields.innerHTML = "";
  el.reviewFields.innerHTML = "";
  el.audioFields.innerHTML = "";
  el.audioMixFields.innerHTML = "";

  document.querySelectorAll(".video-only").forEach(node => {
    node.style.display = state.tab === "video" ? "" : "none";
  });

  if (state.tab === "video") {
    cfg.tech.forEach(field => el.techFields.append(makeSelectField(...field)));
    cfg.review.forEach(item => el.reviewFields.append(makeCheckbox("review", item, true)));
    cfg.audio.forEach(field => el.audioFields.append(makeSelectField(...field)));
    cfg.mix.forEach(item => el.audioMixFields.append(makeCheckbox("mix", item, item.includes("清楚") || item.includes("平衡"))));
  }

  el.qualityFields.innerHTML = "";
  data.quality.forEach(item => el.qualityFields.append(makeCheckbox("quality", item, false)));

  el.negativeFields.innerHTML = "";
  data.negative.forEach(item => el.negativeFields.append(makeCheckbox("negative", item, true)));

  el.output.value = initialText();
  el.status.textContent = "尚未產生";
}

function modeOpening(type, mode) {
  if (!mode) return "任務：依照下列欄位產生通用提示詞。";

  if (type === "image") {
    const imageOpenings = {
      "文生圖模式": "任務：根據以下文字設定生成新圖片。不需要原圖。",
      "圖生圖模式": "任務：依上傳圖片作為主要參考，保留原圖的主要風格、構圖、人物、商品或氛圍，再生成新圖片。請將上傳圖片視為主要參考圖。",
      "修改/置換圖片模式": "任務：依上傳圖片進行局部修改或元素置換。請保留未指定修改的區域，只調整指定內容。",
      "圖生文模式": "任務：分析上傳圖片，反推可重用的提示詞、畫面描述、商品描述或社群文案。請先理解圖片內容，再輸出結構化描述。",
      "提示詞優化模式": "任務：優化既有 prompt，使其更清楚、更高品質，並更適合所選平台。請將原 prompt 作為改寫基礎。"
    };
    return imageOpenings[mode] || "任務：" + mode + "。";
  }

  const videoOpenings = {
    "文生影片模式": "任務：根據以下文字設定生成新影片。不需要原圖或原影片。",
    "圖生影片模式": "任務：依上傳圖片作為主要參考，延伸成影片。請保留參考圖的主體、風格、構圖與氛圍，再加入鏡頭運動與時間變化。",
    "修改/置換影片模式": "任務：依上傳圖片或影片進行局部修改、置換或重製。請保留未指定修改的區域，只調整指定內容。",
    "影片分鏡提示詞": "任務：依照下列分鏡與參考圖結構生成影片。請依序呈現每段分鏡，保持開場、發展、高潮與收尾的連續邏輯，並維持主體、場景、風格、色彩與聲音一致。",
    "提示詞優化模式": "任務：優化既有影片 prompt，使其更清楚、更高品質，並更適合所選平台。請將原 prompt 作為改寫基礎。"
  };
  return videoOpenings[mode] || "任務：" + mode + "。";
}

function initialText() {
  if (state.tab === "image") {
    return [
      "【圖片提示詞編輯器】",
      "",
      "請先選擇模式。模式會影響輸出開頭：",
      "- 文生圖：根據文字生成新圖片",
      "- 圖生圖：依上傳圖片作為主要參考",
      "- 修改/置換圖片：依上傳圖片進行局部修改",
      "- 圖生文：分析上傳圖片並反推描述或 prompt",
      "- 提示詞優化：改寫既有 prompt",
      "",
      "輸出會保留：",
      "1. ## 模式開頭標示",
      "2. ## 中文說明",
      "3. ## Negative Prompt"
    ].join("\n");
  }

  return [
    "【影片提示詞四層結構】",
    "",
    "請先選擇模式。模式會影響輸出開頭：",
    "- 文生影片：根據文字生成新影片",
    "- 圖生影片：依上傳圖片延伸成影片",
    "- 修改/置換影片：依上傳圖片或影片局部修改",
    "- 影片分鏡提示詞：整理成連續分鏡",
    "- 提示詞優化：改寫既有影片 prompt",
    "",
    "第一層：影片提示詞核心",
    "描述主體、場景、動作、劇情、鏡頭、構圖、光線、材質、色彩、風格、用途、比例、時長與節奏。",
    "",
    "第二層：影片技術規格",
    "描述解析度、影格率、編碼、位元率與色彩空間，可作為後製、轉檔、交付參考。",
    "",
    "第三層：專業品質審查",
    "檢查穩定度、時間一致性、透視、分鏡一致性、HUD/UI、字幕安全區與敘事曲線。",
    "",
    "分鏡 / 參考圖結構",
    "選擇 15. 分鏡 / 參考圖數量後，系統會自動產生每段分鏡的畫面、鏡頭、動作、聲音。",
    "",
    "第四層：聲音與音訊設計",
    "描述聲音模式、旁白、對白、音樂、環境音、音效與混音要求。",
    "",
    "輸出會保留中文提示詞與 Negative Prompt，不再輸出 English Prompt 與 JSON。"
  ].join("\n");
}

function buildImagePrompt() {
  const fields = selectedMap(el.dynamicFields);
  const qualities = checkedValues("quality");
  const negatives = checkedValues("negative");
  const opening = modeOpening("image", el.mode.value);
  const zh = "主體是" + (fields.subject || "未指定") + "，場景為" + (fields.scene || "未指定") + "，動作為" + (fields.action || "未指定") + "。構圖採用" + (fields.composition || "未指定") + "，鏡頭為" + (fields.camera || "未指定") + "，光線使用" + (fields.light || "未指定") + "，材質重點是" + (fields.material || "未指定") + "，色彩方向為" + (fields.color || "未指定") + "，整體風格是" + (fields.style || "未指定") + "，用途為" + (fields.useCase || "未指定") + "，比例為" + (fields.ratio || "未指定") + "。品質要求：" + (qualities.join("、") || "自然、清楚、可用") + "。";
  return [
    "## 模式開頭標示",
    opening,
    "",
    "## 中文說明",
    zh,
    "",
    "## Negative Prompt (告訴模型不要什麼)",
    negatives.join("、") || "低品質、變形、模糊"
  ].join("\n");
}

function storyboardScenes(storyboard) {
  if (!storyboard) {
    return "請選擇「15. 分鏡 / 參考圖數量」，用來決定分鏡段落與參考圖片對應。";
  }
  if (storyboard === "無分鏡，單一連續鏡頭") {
    return [
      "本次不使用分鏡，採單一連續鏡頭完成影片。",
      "",
      "### 單一連續鏡頭",
      "對應：不指定參考圖序列",
      "畫面：依第一層欄位建立完整畫面、主體與氛圍。",
      "鏡頭：使用目前「鏡頭運動」與「構圖」設定，保持連續且穩定。",
      "動作：使用「動作」與「劇情/事件」欄位，完成一段連續事件。",
      "聲音：使用第四層「聲音與音訊設計」作為整體方向。"
    ].join("\n");
  }

  const map = {
    "1 張參考圖：單鏡頭延伸": ["單鏡頭延伸"],
    "2 張參考圖：起點 / 終點": ["起點", "終點"],
    "3 張參考圖：開場 / 發展 / 收尾": ["開場", "發展", "收尾"],
    "4 張參考圖：開場 / 發展 / 高潮 / 收尾": ["開場", "發展", "高潮", "收尾"],
    "5 張參考圖：開場 / 建立 / 發展 / 高潮 / 收尾": ["開場", "建立", "發展", "高潮", "收尾"],
    "6 張參考圖：開場 / 建立 / 發展 / 轉折 / 高潮 / 收尾": ["開場", "建立", "發展", "轉折", "高潮", "收尾"]
  };
  const scenes = map[storyboard];
  if (!scenes) return storyboard;

  const purpose = {
    "單鏡頭延伸": "依參考圖延伸動態，保持主體、構圖、風格與氛圍一致。",
    "起點": "建立影片起始畫面、主體位置與初始氛圍。",
    "終點": "定義影片結束畫面、最終姿態或目標狀態。",
    "開場": "建立場景、主體與氛圍。",
    "建立": "補強環境、角色關係或產品狀態。",
    "發展": "推進主體動作、展示商品或延續事件。",
    "轉折": "加入方向變化、情緒轉換或畫面重點切換。",
    "高潮": "呈現關鍵動作、產品亮點或視覺最強段落。",
    "收尾": "收束主體、情緒、產品亮點或品牌畫面。"
  };
  const motion = {
    "單鏡頭延伸": "使用目前「鏡頭運動」與「構圖」設定，讓參考圖自然動起來。",
    "起點": "以穩定構圖建立第一個 keyframe。",
    "終點": "銜接起點並穩定抵達最終 keyframe。",
    "開場": "使用目前「鏡頭運動」與「構圖」設定，建立清楚起始畫面。",
    "建立": "保持連續運鏡，補足環境與主體關係。",
    "發展": "保持連續運鏡，銜接前一段並推進事件。",
    "轉折": "鏡頭可轉向、推進或改變焦點，但需維持視覺連續。",
    "高潮": "可使用特寫、推進或環繞，強調關鍵亮點。",
    "收尾": "穩定構圖、慢速拉遠或定格，形成明確結尾。"
  };
  const action = {
    "單鏡頭延伸": "使用「動作」與「劇情/事件」欄位，形成一段自然連續動作。",
    "起點": "主體出現、場景建立或事件開始。",
    "終點": "完成事件、抵達目標狀態或停留在關鍵畫面。",
    "開場": "主體出現、場景建立或事件開始。",
    "建立": "補充主體狀態、空間關係或產品特徵。",
    "發展": "延續前一段並推進劇情。",
    "轉折": "呈現事件變化、動作轉向或情緒變化。",
    "高潮": "完成最重要的動作、展示或轉折。",
    "收尾": "完成事件，停留在關鍵畫面。"
  };

  const lines = [
    "本次使用 " + scenes.length + " 張參考圖片，對應 " + scenes.length + " 段分鏡。",
    "請依照參考圖順序建立影片節奏，保持角色、服裝、商品、場景、色彩與風格一致。"
  ];
  scenes.forEach((name, index) => {
    lines.push("", "### 分鏡 " + (index + 1) + "：" + name);
    lines.push("對應：參考圖 " + (index + 1));
    lines.push("畫面：" + (purpose[name] || "依目前欄位設定建立畫面。"));
    lines.push("鏡頭：" + (motion[name] || "使用目前鏡頭運動與構圖設定。"));
    lines.push("動作：" + (action[name] || "使用目前動作與劇情設定。"));
    lines.push("聲音：使用第四層「聲音與音訊設計」作為整體方向。");
  });
  return lines.join("\n");
}

function buildVideoPrompt() {
  const fields = selectedMap(el.dynamicFields);
  const tech = selectedMap(el.techFields);
  const audio = selectedMap(el.audioFields);
  const review = checkedValues("review");
  const mix = checkedValues("mix");
  const qualities = checkedValues("quality");
  const negatives = checkedValues("negative");
  const opening = modeOpening("video", el.mode.value);
  const core = "主體是" + (fields.subject || "未指定") + "，場景為" + (fields.scene || "未指定") + "，動作是" + (fields.action || "未指定") + "，劇情事件為" + (fields.story || "未指定") + "。鏡頭運動採用" + (fields.cameraMotion || "未指定") + "，構圖為" + (fields.composition || "未指定") + "，光線是" + (fields.light || "未指定") + "，材質質感為" + (fields.material || "未指定") + "，色彩方向是" + (fields.color || "未指定") + "，風格為" + (fields.style || "未指定") + "，用途是" + (fields.useCase || "未指定") + "，比例" + (fields.ratio || "未指定") + "，時長" + (fields.duration || "未指定") + "，節奏" + (fields.pace || "未指定") + "。分鏡 / 參考圖數量：" + (fields.storyboard || "未指定") + "。品質要求：" + (qualities.join("、") || "自然、清楚、可用") + "。";
  const storyboardText = storyboardScenes(fields.storyboard);
  const techText = Object.entries(tech).map(([key, value]) => "- " + key + ": " + (value || "未指定")).join("\n");
  const audioText = "聲音模式：" + (audio.audioMode || "未指定") + "。旁白：" + (audio.voiceover || "未指定") + "。對白：" + (audio.dialogue || "未指定") + "。音樂：" + (audio.music || "未指定") + "。環境音：" + (audio.ambience || "未指定") + "。音效：" + (audio.sfx || "未指定") + "。混音要求：" + (mix.join("、") || "整體音量平衡") + "。";
  return [
    "# 影片提示詞任務",
    "",
    "## 模式開頭標示",
    opening,
    "",
    "## 第一層：影片提示詞核心",
    core,
    "",
    "## 分鏡 / 參考圖結構",
    storyboardText,
    "",
    "## 第二層：影片技術規格",
    techText,
    "",
    "## 第三層：專業品質審查",
    review.length ? review.map(item => "- " + item).join("\n") : "- 未指定",
    "",
    "## 第四層：聲音與音訊設計",
    audioText,
    "",
    "## Negative Prompt (告訴模型不要什麼)",
    negatives.join("、") || "低品質、變形、閃爍、雜訊"
  ].join("\n");
}

function generate() {
  el.output.value = state.tab === "image" ? buildImagePrompt() : buildVideoPrompt();
  el.status.textContent = `已產生：${new Date().toLocaleString("zh-TW")}`;
}

function clearAll() {
  render();
}

async function copyOutput() {
  if (navigator.clipboard && window.isSecureContext) {
    await navigator.clipboard.writeText(el.output.value);
  } else {
    el.output.focus();
    el.output.select();
    document.execCommand("copy");
  }
  el.status.textContent = "已複製到剪貼簿";
}

function downloadTxt() {
  const blob = new Blob([el.output.value], { type: "text/plain;charset=utf-8" });
  const url = URL.createObjectURL(blob);
  const a = document.createElement("a");
  const stamp = new Date().toISOString().slice(0, 19).replace(/[:T]/g, "-");
  a.href = url;
  a.download = `${state.tab === "image" ? "image" : "video"}-prompt-${stamp}.txt`;
  a.click();
  URL.revokeObjectURL(url);
}

document.querySelectorAll(".tab").forEach(tab => {
  tab.addEventListener("click", () => {
    state.tab = tab.dataset.tab;
    document.querySelectorAll(".tab").forEach(item => item.classList.toggle("active", item === tab));
    render();
  });
});

document.getElementById("generateBtn").addEventListener("click", generate);
document.getElementById("clearBtn").addEventListener("click", clearAll);
document.getElementById("copyBtn").addEventListener("click", copyOutput);
document.getElementById("downloadBtn").addEventListener("click", downloadTxt);

render();
