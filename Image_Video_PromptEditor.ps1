try {
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    $Script:ModePresets = @("文生圖模式", "圖生圖模式", "修改/置換圖片模式", "圖生文模式", "提示詞優化模式")
    $Script:PlatformPresets = @("通用", "ChatGPT", "Midjourney", "SDXL", "Flux", "DALL·E")
    $Script:SubjectPresets = @("", "高質感人物肖像", "商業產品主體", "電影感角色設計", "品牌形象主視覺", "美食商品特寫", "室內空間設計", "自然風景主體", "科技裝置或未來產品", "可愛吉祥物角色", "電商主圖商品", "高端保養品瓶身", "時尚服裝模特兒", "未來感交通工具", "精品包款或配件", "節慶活動主視覺")
    $Script:ScenePresets = @("", "乾淨白色棚拍背景", "高級商業攝影棚", "城市夜景街道", "自然森林與柔和光線", "未來科技實驗室", "極簡室內空間", "高級飯店或精品空間", "夕陽戶外場景", "奇幻世界場景", "透明或純色背景", "雨後街景反光地面", "海邊度假場景", "現代辦公空間", "傳統東方庭院", "大型展覽或舞台場景")
    $Script:ActionPresets = @("", "自然站姿並看向鏡頭", "手持產品展示", "正在使用產品", "動態奔跑或飛行", "優雅坐姿", "轉身回眸", "與背景元素互動", "商品靜物陳列", "無特定動作，由 AI 合理補強", "微笑面向鏡頭", "走路中的自然姿態", "伸手觸碰光源或物件", "產品懸浮展示", "多人互動交流")
    $Script:CompositionPresets = @("", "主體置中，背景乾淨", "三分法構圖，視覺焦點明確", "前景、中景、背景層次分明", "低角度英雄構圖", "大片留白，適合放文字", "對稱構圖，高級穩定感", "近景特寫，突出細節", "廣角環境構圖，強調空間感", "電商主圖構圖，商品完整清楚", "斜線動態構圖", "框景構圖，利用門窗或物件包圍主體", "中心透視構圖，景深延伸", "俯視平鋪構圖", "海報式上方留標題空間")
    $Script:CameraPresets = @("", "特寫鏡頭 (Close-up Shot)", "半身構圖 (Medium Shot)", "遠景全身 (Wide Angle Full Shot)", "低角度仰拍 (Low Angle Heroic View)", "俯瞰鳥瞰 (Top-down Bird's-eye View)", "宏偉極廣角 (Extreme Wide Landscape)", "微距鏡頭 (Macro Lens Close-up)", "85mm 人像鏡頭，淺景深", "35mm 環境人像鏡頭", "無特定，由 AI 依用途合理補強", "50mm 標準鏡頭，自然視角", "24mm 廣角鏡頭，強調空間", "長焦壓縮背景", "肩上視角 Over-the-shoulder", "第一人稱視角 POV")
    $Script:LightPresets = @("", "自然柔和光 (Soft Natural Light)", "黃金夕陽光 (Golden Hour Sunset)", "商業棚拍雙色調 (Dual Studio Lighting)", "側光強對比 (Dramatic Chiaroscuro Side Light)", "魔幻霓虹光 (Cyberpunk Neon Glow)", "林間漏光 (Dappled Sunlight through leaves)", "戲劇性頂光 (Dramatic Top Spotlight)", "窗邊漫射光 (Diffused Window Light)", "高級產品棚拍柔光", "無特定，由 AI 依主體合理補強", "清晨薄霧逆光", "夜晚招牌與街燈混合光", "柔和環形補光", "強烈輪廓邊緣光", "低調暗部高級光影")
    $Script:MaterialPresets = @("", "真實皮膚、自然毛髮、細緻布料", "金屬、玻璃、霧面塑膠、反射材質", "高級皮革、絲綢、羊毛、手工紋理", "木材、石材、陶瓷、自然紋理", "透明壓克力、液體、冰晶、光澤表面", "霧面包裝材質與精緻印刷", "柔軟布料與自然皺褶", "無特定，由 AI 依主體合理補強", "水珠、凝結霧氣、濕潤表面", "碳纖維、橡膠、工業材質", "金箔、亮片、珠寶反光", "紙張、布紋、手作質感", "食品表面油亮與新鮮質地")
    $Script:ColorPresets = @("", "黑白灰極簡高級色調", "暖色系，溫柔明亮", "冷色系，科技與專業感", "高飽和鮮明商業配色", "低飽和電影感色調", "金色與深色高級奢華配色", "粉嫩柔和社群風格", "品牌紅金國風配色", "自然大地色系", "無特定，由 AI 依用途合理補強", "藍橘互補電影色", "莫蘭迪低彩度色系", "黑金精品配色", "清新綠白自然色", "霓虹紫藍科技色")

    $Script:StylePresets = [ordered]@{
        "" = ""
        "寫實攝影 (Photorealistic)" = "Photorealistic, hyper-detailed, taken with 85mm lens, f/1.8, cinematic lighting, sharp focus, volumetric dust"
        "電影感 (Cinematic)" = "Cinematic still, dramatic composition, anamorphic lens flare, moody atmosphere, highly professional color grading"
        "古風寫實 (Chinese Classical)" = "Traditional Chinese realistic painting style, classical elegance, fine brushwork, ink wash undertone, Zen aesthetic"
        "日系動漫 (Anime Style)" = "Japanese anime style, clean and sharp line art, vibrant colors, beautiful sky composition, Kyoto Animation inspired"
        "水彩插畫 (Watercolor)" = "Watercolor illustration, soft washes of color, hand-drawn paper textures, artistic paint splashes, whimsical feel"
        "經典油畫 (Oil Painting)" = "Classic oil painting, textured brushstrokes, rich historical color palette, baroque art style, heavy impasto details"
        "國風插畫 (Modern Guofeng)" = "Modern Chinese Guofeng illustration, red and gold color scheme, mythical elements, decorative patterns, trendy art"
        "3D 渲染 (3D Render)" = "3D render, Octane render, Ray tracing enabled, highly detailed, Unreal Engine 5 aesthetic, smooth materials"
        "商業產品攝影 (Studio)" = "Commercial product photography, studio softbox lighting, clean studio background, reflections, sharp edges, professional look"
        "奇幻概念藝術 (Fantasy)" = "Fantasy concept art, epic scale, mystical atmosphere, majestic structures, digital painting, legendary masterwork"
        "復古海報 (Retro Poster)" = "Vintage poster style, retro textures, screen print effect, muted color palette, mid-century graphic design feel"
        "科幻電影風 (Sci-Fi)" = "Sci-fi movie scene, futuristic technology, neon highlights, holographic elements, cyberpunk high-tech atmosphere"
        "蒸氣龐克 (Steampunk)" = "Steampunk style, gears and brass, steam valves, Victorian machinery, intricate clockwork detailing, sepia tones"
        "像素藝術 (Pixel Art)" = "Pixel art, retro 16-bit aesthetic, detailed sprite work, charming retro video game style, colorful blocks"
        "極簡高級 (Minimal Luxury)" = "Minimal luxury style, clean negative space, premium visual hierarchy, refined details, elegant modern look"
        "可愛療癒 (Cute Kawaii)" = "Cute kawaii style, soft rounded shapes, cheerful mood, pastel palette, charming friendly character design"
        "高端時尚 (High Fashion)" = "High fashion editorial style, bold styling, elegant pose, magazine cover lighting, luxury brand aesthetic"
        "建築室內 (Architecture Interior)" = "Architecture and interior visualization, clean lines, realistic materials, natural daylight, spacious composition"
        "食品廣告 (Food Advertising)" = "Food advertising photography, appetizing texture, fresh ingredients, controlled studio lighting, commercial quality"
    }

    $Script:UseCasePresets = @("", "未指定，由 AI 依主體特徵合理推估", "社群平台貼文 (Social Media Post)", "書籍/網頁封面設計 (Cover Design)", "宣傳海報設計 (Poster & Banner)", "插畫藝術作品 (Artistic Illustration)", "商業產品展示圖 (Product Advertisement)", "電商商品主圖 (E-commerce Hero Image)", "短影音封面 (Short Video Cover)", "品牌形象主視覺 (Brand Key Visual)", "角色設定圖 (Character Concept Art)", "場景概念圖 (Environment Concept Art)", "網站首頁 Hero 圖", "簡報封面圖", "活動主視覺", "廣告投放素材", "LINE/社群貼圖素材")
    $Script:RatioPresets = [ordered]@{ "" = ""; "1:1 (社群頭像/商品)" = "1:1"; "16:9 (橫幅/電影感)" = "16:9"; "9:16 (直式海報/短影音)" = "9:16"; "4:5 (Instagram 貼文)" = "4:5"; "3:2 (專業單眼照)" = "3:2"; "2:3 (直式攝影/書封)" = "2:3"; "21:9 (電影寬螢幕)" = "21:9"; "5:4 (商品與印刷)" = "5:4"; "3:4 (直式人物)" = "3:4"; "2:1 (網站橫幅)" = "2:1"; "1.91:1 (社群連結預覽)" = "1.91:1" }
    $Script:QualityItems = @("高解析度 (Ultra HD)", "高細節 (Intricate Details)", "主體結構明確 (Sharp Focus on Subject)", "構圖平衡完整 (Perfect Composition)", "自然物理比例 (Realistic Proportions)", "畫面乾淨剔透 (Clean Rendering)", "材質紋理清楚 (Detailed Textures)", "色彩和諧協調 (Harmonious Color Palette)", "視覺焦點明確 (Clear Focal Point)", "商業級品質 (Commercial Quality)", "適合正式輸出 (Production Ready)")
    $Script:NegativeItems = @("文字與浮水印 (Text, Watermarks)", "品牌標誌或 Logo (Logos, Brands)", "臉部變形扭曲 (Deformed Faces)", "多餘的肢體 (Extra Limbs)", "手部與手指畸形 (Deformed Hands/Fingers)", "模糊與低解析度 (Blurry, Low-res)", "雜亂搶焦的背景 (Cluttered Background)", "不自然且混亂的光影 (Unnatural Lighting)", "過度銳化與塑料感 (Oversharpened, Plasticy)", "比例錯誤 (Bad Anatomy, Bad Proportions)", "重複物件 (Duplicate Objects)")

    Function Get-SelectedText { param($ComboBox) if ($null -ne $ComboBox.SelectedItem) { return $ComboBox.SelectedItem.ToString() } if ($ComboBox.Text) { return $ComboBox.Text.Trim() } return "" }
    Function Get-CheckedTexts { param($CheckedListBox) $Items = New-Object System.Collections.Generic.List[string]; foreach ($Item in $CheckedListBox.CheckedItems) { [void]$Items.Add($Item.ToString()) }; return $Items.ToArray() }
    Function Resolve-PresetValue { param([string]$SelectedText, $PresetTable) if ([string]::IsNullOrWhiteSpace($SelectedText)) { return "" }; if ($PresetTable -and $PresetTable.Contains($SelectedText)) { return $PresetTable[$SelectedText] }; return $SelectedText }
    Function AutoText { param([string]$Value, [string]$Fallback) if ([string]::IsNullOrWhiteSpace($Value)) { return $Fallback }; return $Value }

    Function Build-EnglishPrompt {
        param([string]$Mode, [string]$Platform, [hashtable]$Fields, [string]$StyleText, [string]$RatioText, [string]$QualityText, [string]$NegativeText)
        $Base = "Subject: $($Fields.Subject). Scene: $($Fields.Scene). Action: $($Fields.Action). Composition: $($Fields.Composition). Camera: $($Fields.Camera). Lighting: $($Fields.Light). Materials: $($Fields.Material). Colors: $($Fields.Color). Style: $StyleText. Use case: $($Fields.UseCase). Aspect ratio: $RatioText. Quality: $QualityText."
        switch -Wildcard ($Mode) {
            "圖生圖模式*" { $Base = "Use the reference image as visual guidance. Preserve important visual identity, composition logic, style direction, and atmosphere while generating a new high-quality image. $Base" }
            "修改/置換圖片模式*" { $Base = "Edit the provided image. Change only requested parts, replace specified elements cleanly, and preserve all unspecified areas, identity, perspective, lighting direction, and material consistency. $Base" }
            "圖生文模式*" { $Base = "Analyze the provided image and write a reusable image-generation prompt. Identify subject, scene, action, composition, camera, lighting, materials, colors, style, use case, aspect ratio, quality traits, and negative prompt suggestions." }
            "提示詞優化模式*" { $Base = "Rewrite and enhance the user's idea or existing prompt into a clear, high-quality image-generation prompt while preserving the original intent. $Base" }
            default { $Base = "Create a high-quality text-to-image result. $Base" }
        }
        switch ($Platform) {
            "Midjourney" { $Ar = if ($RatioText -and $RatioText -notlike "由 AI*") { " --ar $RatioText" } else { "" }; return "$Base Avoid: $NegativeText$Ar --quality 1 --style raw" }
            "SDXL" { return "Positive Prompt:" + [Environment]::NewLine + $Base + [Environment]::NewLine + [Environment]::NewLine + "Negative Prompt:" + [Environment]::NewLine + $NegativeText + [Environment]::NewLine + [Environment]::NewLine + "Recommended Settings:" + [Environment]::NewLine + "Steps: 30, CFG: 6-8, Sampler: DPM++ 2M Karras, Size: follow aspect ratio $RatioText" }
            "Flux" { return "$Base Keep the wording natural and descriptive. Avoid excessive tag stacking. Emphasize coherent subject identity, spatial composition, material realism, and natural lighting." }
            "DALL·E" { return "$Base Use clear natural language. Do not include text, logos, or watermarks unless explicitly requested." }
            "ChatGPT" { return "$Base Please generate or refine the image prompt using clear Chinese guidance plus an English prompt, negative prompt, and structured JSON." }
            default { return $Base }
        }
    }

    Function Get-ImageModeOpening {
        param([string]$Mode)
        switch -Wildcard ($Mode) {
            "文生圖模式*" { return "任務：根據以下文字設定生成新圖片。不需要原圖。" }
            "圖生圖模式*" { return "任務：依上傳圖片作為主要參考，保留原圖的主要風格、構圖、人物、商品或氛圍，再生成新圖片。請將上傳圖片視為主要參考圖。" }
            "修改/置換圖片模式*" { return "任務：依上傳圖片進行局部修改或元素置換。請保留未指定修改的區域，只調整指定內容。" }
            "圖生文模式*" { return "任務：分析上傳圖片，反推可重用的提示詞、畫面描述、商品描述或社群文案。請先理解圖片內容，再輸出結構化描述。" }
            "提示詞優化模式*" { return "任務：優化既有 prompt，使其更清楚、更高品質，並更適合所選平台。請將原 prompt 作為改寫基礎。" }
            default { return "任務：依照下列欄位產生通用圖片提示詞。" }
        }
    }

    Function Build-PromptDocument {
        param([string]$Mode, [string]$Platform, [hashtable]$Fields, [string[]]$Qualities, [string[]]$Negatives)
        $StyleText = Resolve-PresetValue $Fields.Style $Script:StylePresets
        $RatioText = Resolve-PresetValue $Fields.Ratio $Script:RatioPresets
        $Fields.Subject = AutoText $Fields.Subject "由 AI 依模式與用途自動設定高品質主體"
        $Fields.Scene = AutoText $Fields.Scene "由 AI 依主體自動安排合適場景"
        $Fields.Action = AutoText $Fields.Action "由 AI 依主體自動安排自然動作或靜物狀態"
        $Fields.Composition = AutoText $Fields.Composition "主體清楚、視覺焦點明確、構圖平衡完整"
        $Fields.Camera = AutoText $Fields.Camera "由 AI 依用途合理選擇鏡頭"
        $Fields.Light = AutoText $Fields.Light "由 AI 依場景合理補強專業光線"
        $Fields.Material = AutoText $Fields.Material "材質清楚、紋理自然、符合主體特性"
        $Fields.Color = AutoText $Fields.Color "色彩和諧、主次分明、符合用途氛圍"
        $StyleText = AutoText $StyleText "由 AI 依主體特徵合理補強風格"
        $Fields.UseCase = AutoText $Fields.UseCase "未指定，由 AI 依主體合理推估"
        $RatioText = AutoText $RatioText "由 AI 依用途合理決定"
        $QualityText = if ($Qualities -and $Qualities.Count -gt 0) { $Qualities -join ", " } else { "高品質、清晰、完整、可用於正式生成" }
        $NegativeText = if ($Negatives -and $Negatives.Count -gt 0) { $Negatives -join ", " } else { "None" }
        $EnglishPrompt = Build-EnglishPrompt -Mode $Mode -Platform $Platform -Fields $Fields -StyleText $StyleText -RatioText $RatioText -QualityText $QualityText -NegativeText $NegativeText
        $ModeOpening = Get-ImageModeOpening $Mode
        $Out = New-Object System.Text.StringBuilder
        [void]$Out.AppendLine("圖片提示詞任務")
        [void]$Out.AppendLine("模式：$Mode")
        [void]$Out.AppendLine("平台模板：$Platform")
        [void]$Out.AppendLine("")
        [void]$Out.AppendLine("## 模式開頭標示")
        [void]$Out.AppendLine($ModeOpening)
        [void]$Out.AppendLine("")
        [void]$Out.AppendLine("## 中文說明")
        switch -Wildcard ($Mode) {
            "文生圖模式*" { [void]$Out.AppendLine("目的：使用文字或預設條件生成一張高品質新圖片。") }
            "圖生圖模式*" { [void]$Out.AppendLine("目的：以參考圖片為基礎，延伸生成同風格、同構圖邏輯或同主體方向的新圖片。") }
            "修改/置換圖片模式*" { [void]$Out.AppendLine("目的：針對既有圖片進行局部修改、物件置換、背景置換或指定區域修正，並保留未指定改動的部分。") }
            "圖生文模式*" { [void]$Out.AppendLine("目的：分析圖片並反推可重用的描述、提示詞、風格與排除條件。") }
            "提示詞優化模式*" { [void]$Out.AppendLine("目的：將既有想法或 prompt 優化成更清楚、更高品質、更適合指定平台的圖片生成提示詞。") }
        }
        [void]$Out.AppendLine("")
        foreach ($Line in @("主體：$($Fields.Subject)", "場景：$($Fields.Scene)", "動作：$($Fields.Action)", "構圖：$($Fields.Composition)", "鏡頭：$($Fields.Camera)", "光線：$($Fields.Light)", "材質：$($Fields.Material)", "色彩：$($Fields.Color)", "風格：$StyleText", "用途：$($Fields.UseCase)", "比例：$RatioText", "品質要求：$QualityText", "排除條件：$NegativeText")) { [void]$Out.AppendLine($Line) }
        [void]$Out.AppendLine("")
        [void]$Out.AppendLine("## 第四層：聲音與音訊設計")
        foreach ($Line in @("聲音模式：$($AudioSpecs.audio_mode)", "旁白：$($AudioSpecs.voiceover)", "對白：$($AudioSpecs.dialogue)", "音樂風格：$($AudioSpecs.music_style)", "環境音：$($AudioSpecs.ambience)", "音效：$($AudioSpecs.sound_effects)", "字幕：$($AudioSpecs.subtitles)", "混音要求：$($AudioSpecs.mix)")) { [void]$Out.AppendLine($Line) }
        [void]$Out.AppendLine("")
        [void]$Out.AppendLine("------------------------------------------------------------")
        [void]$Out.AppendLine("")
        [void]$Out.AppendLine("## Negative Prompt (告訴模型不要什麼)")
        [void]$Out.AppendLine($NegativeText)
        [void]$Out.AppendLine("")
        [void]$Out.AppendLine("------------------------------------------------------------")
        [void]$Out.AppendLine("")
        [void]$Out.AppendLine("## English Prompt (支援英文生圖)")
        [void]$Out.AppendLine($EnglishPrompt)
        [void]$Out.AppendLine("")
        [void]$Out.AppendLine("## JSON 結構化輸出 (給工具或下一版功能使用)")
        $JsonPayload = [ordered]@{ mode = $Mode; platform = $Platform; subject = $Fields.Subject; scene = $Fields.Scene; action = $Fields.Action; composition = $Fields.Composition; camera = $Fields.Camera; light = $Fields.Light; material = $Fields.Material; color = $Fields.Color; style = $StyleText; use_case = $Fields.UseCase; ratio = $RatioText; quality = $QualityText; negative_prompt = $NegativeText; english_prompt = $EnglishPrompt }
        [void]$Out.AppendLine(($JsonPayload | ConvertTo-Json -Depth 5))
        return $Out.ToString()
    }



    $Script:VideoModePresets = @("文生影片模式", "圖生影片模式", "修改/置換影片模式", "影片分鏡提示詞", "影片轉文字模式", "提示詞優化模式")
    $Script:VideoPlatformPresets = @("通用", "ChatGPT", "Runway", "Pika", "Kling", "Luma", "Sora", "Veo")
    $Script:VideoSubjectPresets = @("", "高質感人物主角", "商業產品展示", "電影感角色", "品牌形象短片", "美食製作過程", "室內空間導覽", "自然風景動態", "科技產品展示", "可愛角色動畫")
    $Script:VideoScenePresets = @("", "城市夜景街道", "乾淨商業攝影棚", "自然森林場景", "未來科技空間", "海邊度假場景", "現代辦公空間", "高級室內空間", "雨後街景", "大型舞台或展覽")
    $Script:VideoActionPresets = @("", "主體自然走向鏡頭", "產品緩慢旋轉展示", "人物與產品互動", "鏡頭跟隨主體移動", "主體從靜止到動作", "環境光線逐漸變化", "物件被替換或變形", "慢動作展示細節")
    $Script:VideoStoryPresets = @("", "從建立氛圍開始，逐步聚焦主體", "展示產品外觀到使用情境", "人物進入場景並完成一個簡短動作", "由遠景推進到主體特寫", "前後對比式變化", "品牌形象短片節奏", "社群短影音開場鉤子")
    $Script:VideoCameraMotionPresets = @("", "緩慢推鏡 Dolly In", "緩慢拉遠 Dolly Out", "水平平移 Pan", "環繞主體 Orbit Shot", "手持紀錄片感 Handheld", "空拍俯衝 Drone Shot", "穩定跟拍 Tracking Shot", "由模糊到清晰 Rack Focus")
    $Script:VideoPacePresets = @("", "平穩慢節奏", "電影感慢動作", "快速社群短影音節奏", "柔和流暢轉場", "高能量廣告節奏", "安靜沉浸式節奏", "逐步揭示主體")
    $Script:VideoDurationPresets = @("", "5 秒", "8 秒", "10 秒", "15 秒", "30 秒")
    $Script:VideoStoryboardPresets = @("", "無分鏡，單一連續鏡頭", "1圖：單鏡頭延伸", "2圖：起點/終點", "3圖：開場/發展/收尾", "4圖：開場/發展/高潮/收尾", "5圖：開場/建立/發展/高潮/收尾", "6圖：開場/建立/發展/轉折/高潮/收尾")
    $Script:VideoQualityItems = @("高解析度", "畫面穩定", "動作自然", "鏡頭運動平滑", "主體一致性", "無閃爍", "材質連續", "光影一致", "商業級質感")
    $Script:VideoNegativeItems = @("畫面閃爍", "主體變形", "臉部扭曲", "手部錯誤", "多餘肢體", "文字浮水印", "Logo", "低解析度", "不自然運動", "鏡頭抖動")

    Function Get-VideoModeOpening {
        param([string]$Mode)
        switch -Wildcard ($Mode) {
            "文生影片模式*" { return "任務：根據以下文字設定生成新影片。不需要原圖或原影片。" }
            "圖生影片模式*" { return "任務：依上傳圖片作為主要參考，延伸成影片。請保留參考圖的主體、風格、構圖與氛圍，再加入鏡頭運動與時間變化。" }
            "修改/置換影片模式*" { return "任務：依上傳圖片或影片進行局部修改、置換或重製。請保留未指定修改的區域，只調整指定內容。" }
            "影片修改/延展模式*" { return "任務：依上傳圖片或影片進行修改、延展或重製。請保留未指定修改的區域，只調整指定內容。" }
            "影片分鏡提示詞*" { return "任務：依照下列分鏡與參考圖結構生成影片。請依序呈現每段分鏡，保持開場、發展、高潮與收尾的連續邏輯，並維持主體、場景、風格、色彩與聲音一致。" }
            "影片轉文字模式*" { return "任務：分析上傳影片或連續畫面，反推可重用的影片提示詞、分鏡描述、畫面說明或社群文案。" }
            "提示詞優化模式*" { return "任務：優化既有影片 prompt，使其更清楚、更高品質，並更適合所選平台。請將原 prompt 作為改寫基礎。" }
            default { return "任務：依照下列欄位產生通用影片提示詞。" }
        }
    }

    Function Get-VideoStoryboardText {
        param([string]$Storyboard)
        if ([string]::IsNullOrWhiteSpace($Storyboard)) { return "請選擇 15. 分鏡 / 參考圖，用來決定分鏡段落與參考圖片對應。" }
        if ($Storyboard -like "無分鏡*") {
            return @("本次不使用分鏡，採單一連續鏡頭完成影片。", "", "### 單一連續鏡頭", "對應：不指定參考圖序列", "畫面：依第一層欄位建立完整畫面、主體與氛圍。", "鏡頭：使用目前鏡頭運動與構圖設定，保持連續且穩定。", "動作：使用動作與劇情/事件欄位，完成一段連續事件。", "聲音：使用第四層聲音與音訊設計作為整體方向。") -join [Environment]::NewLine
        }
        $Scenes = @()
        switch -Wildcard ($Storyboard) {
            "1圖*" { $Scenes = @("單鏡頭延伸") }
            "2圖*" { $Scenes = @("起點", "終點") }
            "3圖*" { $Scenes = @("開場", "發展", "收尾") }
            "4圖*" { $Scenes = @("開場", "發展", "高潮", "收尾") }
            "5圖*" { $Scenes = @("開場", "建立", "發展", "高潮", "收尾") }
            "6圖*" { $Scenes = @("開場", "建立", "發展", "轉折", "高潮", "收尾") }
        }
        if ($Scenes.Count -eq 0) { return $Storyboard }
        $Purpose = @{
            "單鏡頭延伸" = "依參考圖延伸動態，保持主體、構圖、風格與氛圍一致。"
            "起點" = "建立影片起始畫面、主體位置與初始氛圍。"
            "終點" = "定義影片結束畫面、最終姿態或目標狀態。"
            "開場" = "建立場景、主體與氛圍。"
            "建立" = "補強環境、角色關係或產品狀態。"
            "發展" = "推進主體動作、展示商品或延續事件。"
            "轉折" = "加入方向變化、情緒轉換或畫面重點切換。"
            "高潮" = "呈現關鍵動作、產品亮點或視覺最強段落。"
            "收尾" = "收束主體、情緒、產品亮點或品牌畫面。"
        }
        $Motion = @{
            "單鏡頭延伸" = "使用目前鏡頭運動與構圖設定，讓參考圖自然動起來。"
            "起點" = "以穩定構圖建立第一個 keyframe。"
            "終點" = "銜接起點並穩定抵達最終 keyframe。"
            "開場" = "使用目前鏡頭運動與構圖設定，建立清楚起始畫面。"
            "建立" = "保持連續運鏡，補足環境與主體關係。"
            "發展" = "保持連續運鏡，銜接前一段並推進事件。"
            "轉折" = "鏡頭可轉向、推進或改變焦點，但需維持視覺連續。"
            "高潮" = "可使用特寫、推進或環繞，強調關鍵亮點。"
            "收尾" = "穩定構圖、慢速拉遠或定格，形成明確結尾。"
        }
        $Action = @{
            "單鏡頭延伸" = "使用動作與劇情/事件欄位，形成一段自然連續動作。"
            "起點" = "主體出現、場景建立或事件開始。"
            "終點" = "完成事件、抵達目標狀態或停留在關鍵畫面。"
            "開場" = "主體出現、場景建立或事件開始。"
            "建立" = "補充主體狀態、空間關係或產品特徵。"
            "發展" = "延續前一段並推進劇情。"
            "轉折" = "呈現事件變化、動作轉向或情緒變化。"
            "高潮" = "完成最重要的動作、展示或轉折。"
            "收尾" = "完成事件，停留在關鍵畫面。"
        }
        $Lines = New-Object System.Collections.Generic.List[string]
        [void]$Lines.Add("本次使用 $($Scenes.Count) 張參考圖片，對應 $($Scenes.Count) 段分鏡。")
        [void]$Lines.Add("請依照參考圖順序建立影片節奏，保持角色、服裝、商品、場景、色彩與風格一致。")
        for ($i = 0; $i -lt $Scenes.Count; $i++) {
            $Name = $Scenes[$i]
            [void]$Lines.Add("")
            [void]$Lines.Add("### 分鏡 " + ($i + 1) + "：" + $Name)
            [void]$Lines.Add("對應：參考圖 " + ($i + 1))
            [void]$Lines.Add("畫面：" + $Purpose[$Name])
            [void]$Lines.Add("鏡頭：" + $Motion[$Name])
            [void]$Lines.Add("動作：" + $Action[$Name])
            [void]$Lines.Add("聲音：使用第四層聲音與音訊設計作為整體方向。")
        }
        return ($Lines.ToArray() -join [Environment]::NewLine)
    }

    Function Build-VideoPromptDocument {
        param([string]$Mode, [string]$Platform, [hashtable]$Fields, [hashtable]$TechSpecs, [hashtable]$ReviewSpecs, [hashtable]$AudioSpecs, [string[]]$Qualities, [string[]]$Negatives)
        foreach ($Key in @("Subject", "Scene", "Action", "Story", "CameraMotion", "Composition", "Light", "Material", "Color", "Style", "UseCase", "Ratio", "Duration", "Pace", "Storyboard")) {
            if ([string]::IsNullOrWhiteSpace($Fields[$Key])) { $Fields[$Key] = "由 AI 依影片目的合理補強" }
        }
        $QualityText = if ($Qualities -and $Qualities.Count -gt 0) { $Qualities -join ", " } else { "高品質、穩定、自然、可用於正式影片生成" }
        $NegativeText = if ($Negatives -and $Negatives.Count -gt 0) { $Negatives -join ", " } else { "None" }
        if ($null -eq $TechSpecs) { $TechSpecs = [ordered]@{} }
        if ($null -eq $ReviewSpecs) { $ReviewSpecs = [ordered]@{} }
        if ($null -eq $AudioSpecs) { $AudioSpecs = [ordered]@{} }
        $DefaultTechSpecs = [ordered]@{ resolution = "預設"; aspect_ratio = "預設"; frame_rate = "24fps 電影感"; codec = "預設"; bitrate = "預設"; color_space = "預設" }
        $DefaultReviewSpecs = [ordered]@{ stability = ""; temporal_consistency = ""; depth_perspective = ""; modular_consistency = ""; hud_ui_design = ""; accessibility = ""; narrative_arc = "" }
        $DefaultAudioSpecs = [ordered]@{ audio_mode = "無聲，僅輸出畫面提示詞"; voiceover = "無旁白"; dialogue = "無對白"; music_style = "無音樂"; ambience = "無環境音"; sound_effects = "無音效"; subtitles = "無字幕"; mix = "若平台不支援音訊，作為後製配音、配樂與音效設計參考" }
        foreach ($Key in $DefaultTechSpecs.Keys) { if (-not $TechSpecs.ContainsKey($Key) -or [string]::IsNullOrWhiteSpace([string]$TechSpecs[$Key])) { $TechSpecs[$Key] = $DefaultTechSpecs[$Key] } }
        foreach ($Key in $DefaultReviewSpecs.Keys) { if (-not $ReviewSpecs.ContainsKey($Key) -or [string]::IsNullOrWhiteSpace([string]$ReviewSpecs[$Key])) { $ReviewSpecs[$Key] = $DefaultReviewSpecs[$Key] } }
        foreach ($Key in $DefaultAudioSpecs.Keys) { if (-not $AudioSpecs.ContainsKey($Key) -or [string]::IsNullOrWhiteSpace([string]$AudioSpecs[$Key])) { $AudioSpecs[$Key] = $DefaultAudioSpecs[$Key] } }
        $AudioPrompt = "Audio: $($AudioSpecs.audio_mode). Voice-over: $($AudioSpecs.voiceover). Dialogue: $($AudioSpecs.dialogue). Music: $($AudioSpecs.music_style). Ambience: $($AudioSpecs.ambience). Sound effects: $($AudioSpecs.sound_effects). Subtitles: $($AudioSpecs.subtitles). Mix: $($AudioSpecs.mix)."
        $EnglishPrompt = "Create a high-quality video. Mode: $Mode. Subject: $($Fields.Subject). Scene: $($Fields.Scene). Action: $($Fields.Action). Story/Event: $($Fields.Story). Camera motion: $($Fields.CameraMotion). Composition: $($Fields.Composition). Lighting: $($Fields.Light). Materials: $($Fields.Material). Colors: $($Fields.Color). Style: $($Fields.Style). Use case: $($Fields.UseCase). Aspect ratio: $($Fields.Ratio). Duration: $($Fields.Duration). Pace: $($Fields.Pace). Storyboard/reference images: $($Fields.Storyboard). Quality: $QualityText. $AudioPrompt"
        switch ($Platform) {
            "Runway" { $EnglishPrompt += " Keep motion coherent, cinematic, and physically plausible." }
            "Pika" { $EnglishPrompt += " Emphasize clear action, short-form visual impact, and smooth motion." }
            "Kling" { $EnglishPrompt += " Emphasize realistic movement, subject consistency, and strong scene continuity." }
            "Luma" { $EnglishPrompt += " Emphasize natural camera movement, depth, and cinematic realism." }
            "Sora" { $EnglishPrompt += " Use detailed natural language with precise scene, motion, and temporal continuity." }
            "Veo" { $EnglishPrompt += " Use clear cinematic direction, realistic motion, and coherent visual storytelling." }
            "ChatGPT" { $EnglishPrompt += " Please refine this into a platform-ready video generation prompt." }
        }
        $ModeOpening = Get-VideoModeOpening $Mode
        $Out = New-Object System.Text.StringBuilder
        [void]$Out.AppendLine("# 影片提示詞任務")
        [void]$Out.AppendLine("模式：$Mode")
        [void]$Out.AppendLine("平台模板：$Platform")
        [void]$Out.AppendLine("")
        [void]$Out.AppendLine("## 模式開頭標示")
        [void]$Out.AppendLine($ModeOpening)
        [void]$Out.AppendLine("")
        [void]$Out.AppendLine("## 第一層：影片提示詞核心")
        foreach ($Line in @("主體：$($Fields.Subject)", "場景：$($Fields.Scene)", "動作：$($Fields.Action)", "劇情/事件：$($Fields.Story)", "鏡頭運動：$($Fields.CameraMotion)", "構圖：$($Fields.Composition)", "光線：$($Fields.Light)", "材質/質感：$($Fields.Material)", "色彩：$($Fields.Color)", "風格：$($Fields.Style)", "影片用途：$($Fields.UseCase)", "比例：$($Fields.Ratio)", "時長：$($Fields.Duration)", "節奏：$($Fields.Pace)", "分鏡 / 參考圖：$($Fields.Storyboard)")) { [void]$Out.AppendLine($Line) }
        [void]$Out.AppendLine("")
        [void]$Out.AppendLine("## 分鏡 / 參考圖結構")
        [void]$Out.AppendLine((Get-VideoStoryboardText $Fields.Storyboard))
        [void]$Out.AppendLine("")
        [void]$Out.AppendLine("## 第二層：影片技術規格")
        foreach ($Line in @("解析度：$($TechSpecs.resolution)", "畫面比例：$($TechSpecs.aspect_ratio)", "影格率：$($TechSpecs.frame_rate)", "編碼與格式：$($TechSpecs.codec)", "位元率：$($TechSpecs.bitrate)", "色彩空間：$($TechSpecs.color_space)")) { [void]$Out.AppendLine($Line) }
        [void]$Out.AppendLine("")
        [void]$Out.AppendLine("## 第三層：專業品質審查")
        foreach ($Line in @("穩定度：$($ReviewSpecs.stability)", "時間一致性：$($ReviewSpecs.temporal_consistency)", "深度與透視：$($ReviewSpecs.depth_perspective)", "分段一致性：$($ReviewSpecs.modular_consistency)", "資訊覆蓋層：$($ReviewSpecs.hud_ui_design)", "可訪問性：$($ReviewSpecs.accessibility)", "敘事曲線：$($ReviewSpecs.narrative_arc)", "品質要求：$QualityText", "排除條件：$NegativeText")) { [void]$Out.AppendLine($Line) }
        [void]$Out.AppendLine("")
        [void]$Out.AppendLine("------------------------------------------------------------")
        [void]$Out.AppendLine("")
        [void]$Out.AppendLine("## Negative Prompt (告訴模型不要什麼)")
        [void]$Out.AppendLine($NegativeText)
        [void]$Out.AppendLine("")
        [void]$Out.AppendLine("------------------------------------------------------------")
        [void]$Out.AppendLine("")
        [void]$Out.AppendLine("## English Prompt (支援英文影片生成)")
        [void]$Out.AppendLine($EnglishPrompt)
        [void]$Out.AppendLine("")
        [void]$Out.AppendLine("## JSON 結構化輸出 (給工具或下一版功能使用)")
        $JsonPayload = [ordered]@{ mode = $Mode; platform = $Platform; core_prompt = [ordered]@{ subject = $Fields.Subject; scene = $Fields.Scene; action = $Fields.Action; story = $Fields.Story; camera_motion = $Fields.CameraMotion; composition = $Fields.Composition; light = $Fields.Light; material = $Fields.Material; color = $Fields.Color; style = $Fields.Style; use_case = $Fields.UseCase; ratio = $Fields.Ratio; duration = $Fields.Duration; pace = $Fields.Pace; storyboard = $Fields.Storyboard }; technical_specs = $TechSpecs; quality_review = $ReviewSpecs; audio_design = $AudioSpecs; quality = $QualityText; negative_prompt = $NegativeText; english_prompt = $EnglishPrompt }
        [void]$Out.AppendLine(($JsonPayload | ConvertTo-Json -Depth 5))
        return $Out.ToString()
    }

    Function Show-VideoPromptEditor {
        $videoForm = New-Object System.Windows.Forms.Form
        $videoForm.Text = "影片提示詞編輯器"
        $videoForm.Size = New-Object System.Drawing.Size(1180, 760)
        $videoForm.MinimumSize = New-Object System.Drawing.Size(980, 640)
        $videoForm.StartPosition = "CenterParent"
        $videoForm.Font = New-Object System.Drawing.Font("Microsoft JhengHei UI", 10)
        $videoForm.BackColor = [System.Drawing.Color]::FromArgb(245, 246, 248)

        $FontTitleV = New-Object System.Drawing.Font("Microsoft JhengHei UI", 12, [System.Drawing.FontStyle]::Bold)
        $FontLabelV = New-Object System.Drawing.Font("Microsoft JhengHei UI", 10, [System.Drawing.FontStyle]::Bold)
        $FontNormalV = New-Object System.Drawing.Font("Microsoft JhengHei UI", 10)
        $FontCodeV = New-Object System.Drawing.Font("Consolas", 10)

        $left = New-Object System.Windows.Forms.Panel
        $left.Location = New-Object System.Drawing.Point(15, 15)
        $left.Size = New-Object System.Drawing.Size(620, 700)
        $left.Anchor = [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Bottom -bor [System.Windows.Forms.AnchorStyles]::Left
        $left.BackColor = [System.Drawing.Color]::White
        $left.AutoScroll = $true
        $videoForm.Controls.Add($left)

        Function Add-VideoComboField {
            param([string]$LabelText, [int]$Y, [object[]]$Items, [int]$X = 15, [int]$Width = 275)
            $label = New-Object System.Windows.Forms.Label
            $label.Text = $LabelText
            $label.Font = $FontLabelV
            $label.Location = New-Object System.Drawing.Point($X, $Y)
            $label.Size = New-Object System.Drawing.Size($Width, 20)
            $left.Controls.Add($label)
            $combo = New-Object System.Windows.Forms.ComboBox
            $combo.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDown
            $combo.AutoCompleteMode = [System.Windows.Forms.AutoCompleteMode]::SuggestAppend
            $combo.AutoCompleteSource = [System.Windows.Forms.AutoCompleteSource]::ListItems
            $combo.Location = New-Object System.Drawing.Point($X, ($Y + 23))
            $combo.Size = New-Object System.Drawing.Size($Width, 25)
            $combo.Font = $FontNormalV
            $combo.MaxDropDownItems = 20
            $combo.IntegralHeight = $false
            foreach ($Item in $Items) { [void]$combo.Items.Add($Item) }
            if ($combo.Items.Count -gt 0) { $combo.SelectedIndex = 0 }
            $left.Controls.Add($combo)
            return $combo
        }


        $Script:VideoTechSpecs = [ordered]@{
            resolution = "預設"
            aspect_ratio = "預設"
            frame_rate = "24fps 電影感"
            codec = "預設"
            bitrate = "預設"
            color_space = "預設"
        }
        $Script:VideoReviewSpecs = [ordered]@{
            stability = ""
            temporal_consistency = ""
            depth_perspective = ""
            modular_consistency = ""
            hud_ui_design = ""
            accessibility = ""
            narrative_arc = ""
        }
        $Script:VideoAudioSpecs = [ordered]@{
            audio_mode = "無聲，僅輸出畫面提示詞"
            voiceover = "無旁白"
            dialogue = "無對白"
            music_style = "無音樂"
            ambience = "無環境音"
            sound_effects = "無音效"
            subtitles = "無字幕"
            mix = "若平台不支援音訊，作為後製配音、配樂與音效設計參考"
        }

        Function Add-DialogComboField {
            param($Dialog, [string]$LabelText, [int]$Y, [object[]]$Items, [string]$CurrentValue)
            $label = New-Object System.Windows.Forms.Label
            $label.Text = $LabelText
            $label.Font = $FontLabelV
            $label.Location = New-Object System.Drawing.Point(15, $Y)
            $label.Size = New-Object System.Drawing.Size(150, 22)
            $Dialog.Controls.Add($label)
            $combo = New-Object System.Windows.Forms.ComboBox
            $combo.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDown
            $combo.AutoCompleteMode = [System.Windows.Forms.AutoCompleteMode]::SuggestAppend
            $combo.AutoCompleteSource = [System.Windows.Forms.AutoCompleteSource]::ListItems
            $combo.Location = New-Object System.Drawing.Point(170, ($Y - 2))
            $combo.Size = New-Object System.Drawing.Size(390, 25)
            $combo.Font = $FontNormalV
            $combo.MaxDropDownItems = 16
            $combo.IntegralHeight = $false
            if ($Items.Count -eq 0 -or [string]$Items[0] -ne "") { [void]$combo.Items.Add("") }
            foreach ($Item in $Items) { [void]$combo.Items.Add($Item) }
            $combo.Text = $CurrentValue
            $Dialog.Controls.Add($combo)
            return $combo
        }

        Function Show-VideoTechDialog {
            $dialog = New-Object System.Windows.Forms.Form
            $dialog.Text = "第二層：影片技術規格設定"
            $dialog.Size = New-Object System.Drawing.Size(600, 360)
            $dialog.StartPosition = "CenterParent"
            $dialog.Font = $FontNormalV
            $dialog.BackColor = [System.Drawing.Color]::White
            $resolution = Add-DialogComboField $dialog "解析度" 25 @("預設", "1280x720 (720p)", "1920x1080 (1080p)", "2560x1440 (2K/QHD)", "3840x2160 (4K UHD)", "4096x2160 (DCI 4K)", "7680x4320 (8K)", "依平台預設") $Script:VideoTechSpecs.resolution
            $aspect = Add-DialogComboField $dialog "畫面比例" 65 @("預設", "跟隨主視窗比例設定", "16:9 橫式主流", "9:16 手機短影音", "1:1 社群方形", "4:5 社群貼文", "21:9 電影寬螢幕", "2:1 網站橫幅", "3:4 直式人物") $Script:VideoTechSpecs.aspect_ratio
            $fps = Add-DialogComboField $dialog "影格率" 105 @("預設", "23.98fps 電影標準", "24fps 電影感", "25fps PAL / 歐規", "29.97fps 廣播/網路", "30fps 標準網路影片", "50fps 高流暢", "59.94fps 高動態", "60fps 運動/動作場景") $Script:VideoTechSpecs.frame_rate
            $codec = Add-DialogComboField $dialog "編碼與格式" 145 @("預設", "H.264，MP4 發佈用", "H.265 / HEVC，MP4 高壓縮高畫質", "AV1，Web 發佈", "ProRes 422 HQ，MOV 後製", "ProRes 4444，MOV 含透明/高階後製", "DNxHR HQX，MOV/MXF 後製", "依平台預設") $Script:VideoTechSpecs.codec
            $bitrate = Add-DialogComboField $dialog "位元率" 185 @("預設", "1080p 10-20 Mbps，VBR", "1080p 20-35 Mbps，高品質", "4K 35-68 Mbps，VBR", "4K 68-100 Mbps，高品質", "社群平台自動壓縮最佳化", "後製用高位元率", "依平台預設") $Script:VideoTechSpecs.bitrate
            $colorSpace = Add-DialogComboField $dialog "色彩空間" 225 @("預設", "Rec.709 (HD 標準)", "Rec.2020 (4K/HDR 規格)", "DCI-P3 (電影/廣色域)", "sRGB (Web 標準)", "Log / Flat，保留後製調色空間", "HDR10 / HLG，HDR 交付", "依平台預設") $Script:VideoTechSpecs.color_space
            $ok = New-Object System.Windows.Forms.Button
            $ok.Text = "套用"
            $ok.Location = New-Object System.Drawing.Point(340, 280)
            $ok.Size = New-Object System.Drawing.Size(100, 32)
            $ok.Add_Click({
                $Script:VideoTechSpecs.resolution = $resolution.Text
                $Script:VideoTechSpecs.aspect_ratio = $aspect.Text
                $Script:VideoTechSpecs.frame_rate = $fps.Text
                $Script:VideoTechSpecs.codec = $codec.Text
                $Script:VideoTechSpecs.bitrate = $bitrate.Text
                $Script:VideoTechSpecs.color_space = $colorSpace.Text
                $dialog.DialogResult = [System.Windows.Forms.DialogResult]::OK
                $dialog.Close()
            })
            $dialog.Controls.Add($ok)
            $cancel = New-Object System.Windows.Forms.Button
            $cancel.Text = "取消"
            $cancel.Location = New-Object System.Drawing.Point(460, 280)
            $cancel.Size = New-Object System.Drawing.Size(100, 32)
            $cancel.Add_Click({ $dialog.Close() })
            $dialog.Controls.Add($cancel)
            [void]$dialog.ShowDialog($videoForm)
        }

        Function Show-VideoReviewDialog {
            $dialog = New-Object System.Windows.Forms.Form
            $dialog.Text = "第三層：專業品質審查設定"
            $dialog.Size = New-Object System.Drawing.Size(640, 430)
            $dialog.StartPosition = "CenterParent"
            $dialog.Font = $FontNormalV
            $dialog.BackColor = [System.Drawing.Color]::White
            $stability = Add-DialogComboField $dialog "穩定度" 25 @("鏡頭運動平滑，無抖動、flicker 或 artifacts", "手持感但不暈眩", "完全穩定商業棚拍", "動態運動但主體穩定", "允許少量自然晃動") $Script:VideoReviewSpecs.stability
            $temporal = Add-DialogComboField $dialog "時間一致性" 65 @("角色特徵、物件結構、材質在所有影格間保持穩定", "人物臉部與服裝全程一致", "產品外觀與 Logo 位置不漂移", "場景物件不突然變形或消失", "動作連續，無跳幀感") $Script:VideoReviewSpecs.temporal_consistency
            $depth = Add-DialogComboField $dialog "深度與透視" 105 @("景深與透視符合光學邏輯，視角轉換自然", "淺景深突出主體", "深景深保留環境資訊", "空間透視穩定，無扭曲", "鏡頭轉向符合真實拍攝邏輯") $Script:VideoReviewSpecs.depth_perspective
            $modular = Add-DialogComboField $dialog "分段一致性" 145 @("分鏡間色彩校正、光線與整體風格一致", "每段保持同一角色與場景設定", "轉場自然，風格不跳脫", "品牌色與視覺語言一致", "不同鏡頭間曝光與白平衡一致") $Script:VideoReviewSpecs.modular_consistency
            $hud = Add-DialogComboField $dialog "HUD/UI" 185 @("若有 HUD/UI，需高解析、高對比，動態背景下仍可讀", "不需要 HUD/UI 或文字覆蓋", "字幕區需保留乾淨空間", "科技介面需清楚、銳利、無亂碼", "UI 動畫需平滑且不遮擋主體") $Script:VideoReviewSpecs.hud_ui_design
            $accessibility = Add-DialogComboField $dialog "可訪問性" 225 @("教育或訓練用途需預留字幕與音頻描述空間", "保留字幕安全區", "畫面不依賴小字說明", "高對比，方便閱讀", "無特殊需求") $Script:VideoReviewSpecs.accessibility
            $arc = Add-DialogComboField $dialog "敘事曲線" 265 @("開場、發展、高潮、收尾具備連續敘事邏輯", "環境建立 → 主體登場 → 動作展示 → 結尾定格", "問題 → 解法 → 展示 → 品牌收束", "目標鎖定 → 動作執行 → 精確命中 → 撤離收尾", "產品外觀 → 賣點展示 → 使用情境 → 品牌結尾", "鉤子開場 → 快速展示 → 記憶點收尾") $Script:VideoReviewSpecs.narrative_arc
            $ok = New-Object System.Windows.Forms.Button
            $ok.Text = "套用"
            $ok.Location = New-Object System.Drawing.Point(380, 340)
            $ok.Size = New-Object System.Drawing.Size(100, 32)
            $ok.Add_Click({
                $Script:VideoReviewSpecs.stability = $stability.Text
                $Script:VideoReviewSpecs.temporal_consistency = $temporal.Text
                $Script:VideoReviewSpecs.depth_perspective = $depth.Text
                $Script:VideoReviewSpecs.modular_consistency = $modular.Text
                $Script:VideoReviewSpecs.hud_ui_design = $hud.Text
                $Script:VideoReviewSpecs.accessibility = $accessibility.Text
                $Script:VideoReviewSpecs.narrative_arc = $arc.Text
                $dialog.DialogResult = [System.Windows.Forms.DialogResult]::OK
                $dialog.Close()
            })
            $dialog.Controls.Add($ok)
            $cancel = New-Object System.Windows.Forms.Button
            $cancel.Text = "取消"
            $cancel.Location = New-Object System.Drawing.Point(500, 340)
            $cancel.Size = New-Object System.Drawing.Size(100, 32)
            $cancel.Add_Click({ $dialog.Close() })
            $dialog.Controls.Add($cancel)
            [void]$dialog.ShowDialog($videoForm)
        }

        Function Show-VideoAudioDialog {
            $dialog = New-Object System.Windows.Forms.Form
            $dialog.Text = "第四層：聲音設定"
            $dialog.Size = New-Object System.Drawing.Size(640, 525)
            $dialog.StartPosition = "CenterParent"
            $dialog.Font = $FontNormalV
            $dialog.BackColor = [System.Drawing.Color]::White
            $audioMode = Add-DialogComboField $dialog "聲音模式" 25 @("無聲，僅輸出畫面提示詞", "背景音樂", "環境音", "旁白", "對白", "音樂 + 環境音", "音樂 + 環境音 + 旁白", "完整聲音設計") $Script:VideoAudioSpecs.audio_mode
            $voiceover = Add-DialogComboField $dialog "旁白" 65 @("無旁白", "中文旁白", "英文旁白", "中英雙語旁白", "溫柔女聲", "專業男聲", "電影預告旁白", "教學說明旁白", "品牌形象旁白") $Script:VideoAudioSpecs.voiceover
            $dialogue = Add-DialogComboField $dialog "對白" 105 @("無對白", "自然生活對白", "產品介紹對白", "角色短句互動", "旁白式獨白", "訪談式對話", "中英雙語對白", "保留口型同步空間") $Script:VideoAudioSpecs.dialogue
            $music = Add-DialogComboField $dialog "音樂風格" 145 @("無音樂", "電影配樂", "科技感電子音樂", "溫暖鋼琴", "緊張懸疑", "輕快社群短影音", "史詩管弦樂", "Lo-fi 輕音樂", "高級品牌氛圍音樂") $Script:VideoAudioSpecs.music_style
            $ambience = Add-DialogComboField $dialog "環境音" 185 @("無環境音", "城市街道聲", "海浪聲", "風聲", "雨聲", "室內空間混響", "機械運作聲", "人群背景聲", "自然森林聲", "展場環境聲") $Script:VideoAudioSpecs.ambience
            $sfx = Add-DialogComboField $dialog "音效" 225 @("無音效", "轉場音效", "UI 點擊音", "產品亮相音效", "爆發/衝擊音效", "柔和提示音", "科技掃描音", "鏡頭推進低頻音", "魔法粒子音效") $Script:VideoAudioSpecs.sound_effects
            $subtitles = Add-DialogComboField $dialog "字幕" 265 @("無字幕", "中文字幕", "英文字幕", "中英雙語字幕", "預留字幕安全區", "社群短影音大字幕", "教育訓練字幕", "無字幕但保留標題區") $Script:VideoAudioSpecs.subtitles
            $mixLabel = New-Object System.Windows.Forms.Label
            $mixLabel.Text = "混音要求（可多選）"
            $mixLabel.Font = $FontLabelV
            $mixLabel.Location = New-Object System.Drawing.Point(15, 305)
            $mixLabel.Size = New-Object System.Drawing.Size(150, 22)
            $dialog.Controls.Add($mixLabel)
            $mix = New-Object System.Windows.Forms.CheckedListBox
            $mix.CheckOnClick = $true
            $mix.Location = New-Object System.Drawing.Point(170, 303)
            $mix.Size = New-Object System.Drawing.Size(390, 105)
            $mix.Font = $FontNormalV
            $mixItems = @("若平台不支援音訊，作為後製配音、配樂與音效設計參考", "旁白清楚優先", "音樂不蓋過旁白", "環境音自然低音量", "整體音量平衡", "適合社群平台播放", "電影感寬動態混音", "人聲、音樂、環境音三者分層清楚", "低頻不混濁", "高頻不刺耳", "保留對話清晰度", "轉場音效不突兀")
            foreach ($Item in $mixItems) {
                $index = $mix.Items.Add($Item)
                if (($Script:VideoAudioSpecs.mix -like "*$Item*") -or ([string]::IsNullOrWhiteSpace($Script:VideoAudioSpecs.mix) -and $index -eq 0)) { $mix.SetItemChecked($index, $true) }
            }
            $dialog.Controls.Add($mix)
            $ok = New-Object System.Windows.Forms.Button
            $ok.Text = "套用"
            $ok.Location = New-Object System.Drawing.Point(380, 425)
            $ok.Size = New-Object System.Drawing.Size(100, 32)
            $ok.Add_Click({ $mixSelected = New-Object System.Collections.Generic.List[string]; foreach ($item in $mix.CheckedItems) { [void]$mixSelected.Add($item.ToString()) }; if ($mixSelected.Count -eq 0) { [void]$mixSelected.Add("若平台不支援音訊，作為後製配音、配樂與音效設計參考") }; $Script:VideoAudioSpecs.audio_mode = $audioMode.Text; $Script:VideoAudioSpecs.voiceover = $voiceover.Text; $Script:VideoAudioSpecs.dialogue = $dialogue.Text; $Script:VideoAudioSpecs.music_style = $music.Text; $Script:VideoAudioSpecs.ambience = $ambience.Text; $Script:VideoAudioSpecs.sound_effects = $sfx.Text; $Script:VideoAudioSpecs.subtitles = $subtitles.Text; $Script:VideoAudioSpecs.mix = ($mixSelected.ToArray() -join "、"); $dialog.DialogResult = [System.Windows.Forms.DialogResult]::OK; $dialog.Close() })
            $dialog.Controls.Add($ok)
            $cancel = New-Object System.Windows.Forms.Button
            $cancel.Text = "取消"
            $cancel.Location = New-Object System.Drawing.Point(500, 425)
            $cancel.Size = New-Object System.Drawing.Size(100, 32)
            $cancel.Add_Click({ $dialog.Close() })
            $dialog.Controls.Add($cancel)
            [void]$dialog.ShowDialog($videoForm)
        }

        $title = New-Object System.Windows.Forms.Label
        $title.Text = "影片提示詞規格選項"
        $title.Font = $FontTitleV
        $title.Location = New-Object System.Drawing.Point(15, 10)
        $title.Size = New-Object System.Drawing.Size(260, 25)
        $left.Controls.Add($title)
        $btnTechSpecs = New-Object System.Windows.Forms.Button
        $btnTechSpecs.Text = "技術規格設定"
        $btnTechSpecs.Location = New-Object System.Drawing.Point(15, 40)
        $btnTechSpecs.Size = New-Object System.Drawing.Size(130, 28)
        $btnTechSpecs.Add_Click({ Show-VideoTechDialog })
        $left.Controls.Add($btnTechSpecs)
        $btnReviewSpecs = New-Object System.Windows.Forms.Button
        $btnReviewSpecs.Text = "品質審查設定"
        $btnReviewSpecs.Location = New-Object System.Drawing.Point(155, 40)
        $btnReviewSpecs.Size = New-Object System.Drawing.Size(130, 28)
        $btnReviewSpecs.Add_Click({ Show-VideoReviewDialog })
        $left.Controls.Add($btnReviewSpecs)
        $btnAudioSpecs = New-Object System.Windows.Forms.Button
        $btnAudioSpecs.Text = "聲音設定"
        $btnAudioSpecs.Location = New-Object System.Drawing.Point(295, 40)
        $btnAudioSpecs.Size = New-Object System.Drawing.Size(130, 28)
        $btnAudioSpecs.Add_Click({ Show-VideoAudioDialog })
        $left.Controls.Add($btnAudioSpecs)
        $mode = Add-VideoComboField "模式" 80 $Script:VideoModePresets 15 255
        $mode.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList
        $platform = Add-VideoComboField "平台模板" 80 $Script:VideoPlatformPresets 310 255
        $platform.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList
        $subject = Add-VideoComboField "1. 主體" 140 $Script:VideoSubjectPresets 15 275
        $scene = Add-VideoComboField "2. 場景" 140 $Script:VideoScenePresets 310 255
        $action = Add-VideoComboField "3. 動作" 200 $Script:VideoActionPresets 15 275
        $story = Add-VideoComboField "4. 劇情/事件" 200 $Script:VideoStoryPresets 310 255
        $cameraMotion = Add-VideoComboField "5. 鏡頭運動" 260 $Script:VideoCameraMotionPresets 15 275
        $composition = Add-VideoComboField "6. 構圖" 260 $Script:CompositionPresets 310 255
        $light = Add-VideoComboField "7. 光線" 320 $Script:LightPresets 15 275
        $material = Add-VideoComboField "8. 材質/質感" 320 $Script:MaterialPresets 310 255
        $color = Add-VideoComboField "9. 色彩" 380 $Script:ColorPresets 15 275
        $style = Add-VideoComboField "10. 風格" 380 @($Script:StylePresets.Keys) 310 255
        $useCase = Add-VideoComboField "11. 影片用途" 440 $Script:UseCasePresets 15 275
        $ratio = Add-VideoComboField "12. 比例" 440 @($Script:RatioPresets.Keys) 310 255
        $duration = Add-VideoComboField "13. 時長" 500 $Script:VideoDurationPresets 15 275
        $pace = Add-VideoComboField "14. 節奏" 500 $Script:VideoPacePresets 310 255
        $storyboard = Add-VideoComboField "15. 分鏡 / 參考圖" 548 $Script:VideoStoryboardPresets 15 550

        $ql = New-Object System.Windows.Forms.Label
        $ql.Text = "16. 品質要求"
        $ql.Font = $FontLabelV
        $ql.Location = New-Object System.Drawing.Point(15, 604)
        $ql.Size = New-Object System.Drawing.Size(275, 20)
        $left.Controls.Add($ql)
        $quality = New-Object System.Windows.Forms.CheckedListBox
        $quality.Location = New-Object System.Drawing.Point(15, 627)
        $quality.Size = New-Object System.Drawing.Size(275, 88)
        $quality.CheckOnClick = $true
        foreach ($Item in $Script:VideoQualityItems) { [void]$quality.Items.Add($Item) }
        $left.Controls.Add($quality)
        $nl = New-Object System.Windows.Forms.Label
        $nl.Text = "17. 排除條件"
        $nl.Font = $FontLabelV
        $nl.Location = New-Object System.Drawing.Point(310, 604)
        $nl.Size = New-Object System.Drawing.Size(255, 20)
        $left.Controls.Add($nl)
        $negative = New-Object System.Windows.Forms.CheckedListBox
        $negative.Location = New-Object System.Drawing.Point(310, 627)
        $negative.Size = New-Object System.Drawing.Size(255, 88)
        $negative.CheckOnClick = $true
        foreach ($Item in $Script:VideoNegativeItems) { [void]$negative.Items.Add($Item) }
        for ($i = 0; $i -lt $negative.Items.Count; $i++) { $negative.SetItemChecked($i, $true) }
        $left.Controls.Add($negative)

        $right = New-Object System.Windows.Forms.Panel
        $right.Location = New-Object System.Drawing.Point(655, 15)
        $right.Size = New-Object System.Drawing.Size(490, 700)
        $right.Anchor = [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Bottom -bor [System.Windows.Forms.AnchorStyles]::Left -bor [System.Windows.Forms.AnchorStyles]::Right
        $right.BackColor = [System.Drawing.Color]::White
        $videoForm.Controls.Add($right)
        $rt = New-Object System.Windows.Forms.Label
        $rt.Text = "影片輸出預覽"
        $rt.Font = $FontTitleV
        $rt.Location = New-Object System.Drawing.Point(15, 10)
        $rt.Size = New-Object System.Drawing.Size(180, 30)
        $right.Controls.Add($rt)
        $clearVideo = New-Object System.Windows.Forms.Button
        $clearVideo.Text = "清除"
        $clearVideo.Location = New-Object System.Drawing.Point(75, 8)
        $clearVideo.Size = New-Object System.Drawing.Size(120, 32)
        $clearVideo.Anchor = [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Right
        $clearVideo.BackColor = [System.Drawing.Color]::FromArgb(226, 232, 240)
        $clearVideo.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
        $clearVideo.FlatAppearance.BorderSize = 0
        $right.Controls.Add($clearVideo)
        $copy = New-Object System.Windows.Forms.Button
        $copy.Text = "複製"
        $copy.Location = New-Object System.Drawing.Point(210, 8)
        $copy.Size = New-Object System.Drawing.Size(130, 32)
        $copy.Anchor = [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Right
        $right.Controls.Add($copy)
        $save = New-Object System.Windows.Forms.Button
        $save.Text = "另存 TXT"
        $save.Location = New-Object System.Drawing.Point(345, 8)
        $save.Size = New-Object System.Drawing.Size(130, 32)
        $save.Anchor = [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Right
        $right.Controls.Add($save)
        $output = New-Object System.Windows.Forms.TextBox
        $output.Multiline = $true
        $output.ScrollBars = [System.Windows.Forms.ScrollBars]::Vertical
        $output.Location = New-Object System.Drawing.Point(15, 50)
        $output.Size = New-Object System.Drawing.Size(460, 630)
        $output.Anchor = [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Bottom -bor [System.Windows.Forms.AnchorStyles]::Left -bor [System.Windows.Forms.AnchorStyles]::Right
        $output.Font = $FontCodeV
        $output.BackColor = [System.Drawing.Color]::FromArgb(247, 250, 252)
        $right.Controls.Add($output)
        $VideoInitialPreviewText = @"
【影片提示詞四層結構】

這裡會產出影片提示詞。一般使用時，先選左側欄位，再按「產出影片提示詞」。

============================================================
第一層：影片提示詞核心
============================================================
用途：描述影片要生成什麼內容，會直接影響模型畫面。

包含：
1. 主體
2. 場景
3. 動作
4. 劇情/事件
5. 鏡頭運動
6. 構圖
7. 光線
8. 材質/質感
9. 色彩
10. 風格
11. 影片用途
12. 比例
13. 時長
14. 節奏

============================================================
第二層：影片技術規格
============================================================
用途：描述影片交付與輸出規格，有些平台不一定能直接控制，但可作為後製、轉檔、交付參考。

包含：
- 解析度：例如 1920x1080、3840x2160
- 畫面比例：例如 16:9、9:16、21:9
- 影格率：例如 24fps、30fps、60fps
- 編碼與格式：例如 H.264 / H.265 / ProRes
- 位元率：例如 1080p 10-20 Mbps、4K 35-68 Mbps
- 色彩空間：例如 Rec.709、Rec.2020

============================================================
第三層：專業品質審查
============================================================
用途：用來檢查影片是否達到專業品質，避免 AI 影片常見問題。

包含：
- 穩定度：鏡頭平滑，避免 flicker 或 artifacts
- 時間一致性：角色、物件、材質在影格間保持穩定
- 深度與透視：景深與視角轉換符合拍攝邏輯
- 分段一致性：分鏡間色彩、光線、風格一致
- 資訊覆蓋層：HUD/UI 需高解析、高對比、可讀
- 可訪問性：教育訓練用途可預留字幕與音頻描述空間
- 敘事曲線：開場、發展、高潮、收尾具備連續邏輯

============================================================
第四層：聲音與音訊設計
============================================================
用途：描述影片需要的聲音方向，方便生成影片時保留音訊意圖，也可作為後製配音、配樂、音效與字幕參考。

包含：
- 聲音模式：無聲、背景音樂、環境音、旁白、對白或完整聲音設計
- 旁白：中文、英文、中英雙語、品牌形象、教學說明或電影預告感
- 對白：角色互動、產品介紹、訪談式對話或保留口型同步空間
- 音樂風格：電影配樂、科技感電子、鋼琴、懸疑、社群短影音或高級品牌氛圍
- 環境音：城市、海浪、風雨、室內混響、機械、人群或自然聲
- 音效：轉場、UI 點擊、產品亮相、衝擊、科技掃描或鏡頭推進低頻
- 字幕：中文、英文、中英雙語、社群大字幕、教育訓練字幕或字幕安全區
- 混音要求：可多選，例如旁白清楚、音樂不蓋過旁白、音量平衡、分層清楚

============================================================
產出後會顯示
============================================================

1. ## 第一層：影片提示詞核心
2. ## 第二層：影片技術規格
3. ## 第三層：專業品質審查
4. ## 第四層：聲音與音訊設計
5. ## Negative Prompt (告訴模型不要什麼)
6. ## English Prompt (支援英文影片生成)
7. ## JSON 結構化輸出 (給工具或下一版功能使用)
"@
        $output.Text = $VideoInitialPreviewText

        $gen = New-Object System.Windows.Forms.Button
        $gen.Text = "產出影片提示詞"
        $gen.Location = New-Object System.Drawing.Point(455, 40)
        $gen.Size = New-Object System.Drawing.Size(150, 28)
        $gen.Anchor = [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Left
        $gen.BackColor = [System.Drawing.Color]::FromArgb(49, 151, 149)
        $gen.ForeColor = [System.Drawing.Color]::White
        $gen.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
        $gen.FlatAppearance.BorderSize = 0
        $left.Controls.Add($gen)


        $gen.Add_Click({
            $Fields = @{ Subject = Get-SelectedText $subject; Scene = Get-SelectedText $scene; Action = Get-SelectedText $action; Story = Get-SelectedText $story; CameraMotion = Get-SelectedText $cameraMotion; Composition = Get-SelectedText $composition; Light = Get-SelectedText $light; Material = Get-SelectedText $material; Color = Get-SelectedText $color; Style = Get-SelectedText $style; UseCase = Get-SelectedText $useCase; Ratio = Get-SelectedText $ratio; Duration = Get-SelectedText $duration; Pace = Get-SelectedText $pace; Storyboard = Get-SelectedText $storyboard }
            $output.Text = Build-VideoPromptDocument -Mode (Get-SelectedText $mode) -Platform (Get-SelectedText $platform) -Fields $Fields -TechSpecs $Script:VideoTechSpecs -ReviewSpecs $Script:VideoReviewSpecs -AudioSpecs $Script:VideoAudioSpecs -Qualities (Get-CheckedTexts $quality) -Negatives (Get-CheckedTexts $negative)
        })
        $clearVideo.Add_Click({
            foreach ($Combo in @($subject, $scene, $action, $story, $cameraMotion, $composition, $light, $material, $color, $style, $useCase, $ratio, $duration, $pace, $storyboard)) {
                if ($Combo.Items.Count -gt 0) { $Combo.SelectedIndex = 0 }
                $Combo.Text = ""
            }
            $mode.SelectedIndex = 0
            $platform.SelectedIndex = 0
            for ($i = 0; $i -lt $quality.Items.Count; $i++) { $quality.SetItemChecked($i, $false) }
            for ($i = 0; $i -lt $negative.Items.Count; $i++) { $negative.SetItemChecked($i, $true) }
            $Script:VideoTechSpecs.resolution = "預設"
            $Script:VideoTechSpecs.aspect_ratio = "預設"
            $Script:VideoTechSpecs.frame_rate = "24fps 電影感"
            $Script:VideoTechSpecs.codec = "預設"
            $Script:VideoTechSpecs.bitrate = "預設"
            $Script:VideoTechSpecs.color_space = "預設"
            $Script:VideoReviewSpecs.stability = ""
            $Script:VideoReviewSpecs.temporal_consistency = ""
            $Script:VideoReviewSpecs.depth_perspective = ""
            $Script:VideoReviewSpecs.modular_consistency = ""
            $Script:VideoReviewSpecs.hud_ui_design = ""
            $Script:VideoReviewSpecs.accessibility = ""
            $Script:VideoReviewSpecs.narrative_arc = ""
            $Script:VideoAudioSpecs.audio_mode = "無聲，僅輸出畫面提示詞"
            $Script:VideoAudioSpecs.voiceover = "無旁白"
            $Script:VideoAudioSpecs.dialogue = "無對白"
            $Script:VideoAudioSpecs.music_style = "無音樂"
            $Script:VideoAudioSpecs.ambience = "無環境音"
            $Script:VideoAudioSpecs.sound_effects = "無音效"
            $Script:VideoAudioSpecs.subtitles = "無字幕"
            $Script:VideoAudioSpecs.mix = "若平台不支援音訊，作為後製配音、配樂與音效設計參考"
            $output.Text = $VideoInitialPreviewText
        })
        $copy.Add_Click({ if (-not [string]::IsNullOrWhiteSpace($output.Text)) { [System.Windows.Forms.Clipboard]::SetText($output.Text) } })
        $save.Add_Click({
            if ([string]::IsNullOrWhiteSpace($output.Text)) { return }
            $SaveDialog = New-Object System.Windows.Forms.SaveFileDialog
            $SaveDialog.Filter = "純文字檔案 (*.txt)|*.txt"
            $SaveDialog.Title = "將影片提示詞儲存為文字檔"
            $SaveDialog.FileName = (Get-Date -Format "yyyyMMdd") + "_影片提示詞.txt"
            if ($SaveDialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) { [System.IO.File]::WriteAllText($SaveDialog.FileName, $output.Text, [System.Text.Encoding]::UTF8) }
        })
        [void]$videoForm.ShowDialog($form)
    }

    $form = New-Object System.Windows.Forms.Form
    $form.Text = "高品質圖片提示詞編輯器 "
    $form.Size = New-Object System.Drawing.Size(1180, 760)
    $form.MinimumSize = New-Object System.Drawing.Size(980, 640)
    $form.StartPosition = "CenterScreen"
    $form.Font = New-Object System.Drawing.Font("Microsoft JhengHei UI", 10)
    $form.BackColor = [System.Drawing.Color]::FromArgb(245, 246, 248)
    $form.GetType().GetProperty("DoubleBuffered", [System.Reflection.BindingFlags]"Instance, NonPublic").SetValue($form, $true, $null)
    $FontTitle = New-Object System.Drawing.Font("Microsoft JhengHei UI", 12, [System.Drawing.FontStyle]::Bold)
    $FontLabel = New-Object System.Drawing.Font("Microsoft JhengHei UI", 10, [System.Drawing.FontStyle]::Bold)
    $FontNormal = New-Object System.Drawing.Font("Microsoft JhengHei UI", 10)
    $FontCode = New-Object System.Drawing.Font("Consolas", 10)

    $pnlLeft = New-Object System.Windows.Forms.Panel
    $pnlLeft.Location = New-Object System.Drawing.Point(15, 15)
    $pnlLeft.Size = New-Object System.Drawing.Size(620, 700)
    $pnlLeft.Anchor = [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Bottom -bor [System.Windows.Forms.AnchorStyles]::Left
    $pnlLeft.BackColor = [System.Drawing.Color]::White
    $pnlLeft.AutoScroll = $true
    $form.Controls.Add($pnlLeft)

    Function Add-ComboField {
        param([string]$LabelText, [int]$Y, [object[]]$Items, [int]$X = 15, [int]$Width = 535)
        $Label = New-Object System.Windows.Forms.Label
        $Label.Text = $LabelText
        $Label.Font = $FontLabel
        $Label.Location = New-Object System.Drawing.Point($X, $Y)
        $Label.Size = New-Object System.Drawing.Size($Width, 20)
        $pnlLeft.Controls.Add($Label)
        $Combo = New-Object System.Windows.Forms.ComboBox
        $Combo.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDown
        $Combo.AutoCompleteMode = [System.Windows.Forms.AutoCompleteMode]::SuggestAppend
        $Combo.AutoCompleteSource = [System.Windows.Forms.AutoCompleteSource]::ListItems
        $Combo.Location = New-Object System.Drawing.Point($X, ($Y + 23))
        $Combo.Size = New-Object System.Drawing.Size($Width, 25)
        $Combo.Font = $FontNormal
        $Combo.MaxDropDownItems = 20
        $Combo.IntegralHeight = $false
        foreach ($Item in $Items) { [void]$Combo.Items.Add($Item) }
        if ($Combo.Items.Count -gt 0) { $Combo.SelectedIndex = 0 }
        $pnlLeft.Controls.Add($Combo)
        return $Combo
    }

    $lblLeftTitle = New-Object System.Windows.Forms.Label
    $lblLeftTitle.Text = "高品質圖片生成規格選項編輯"
    $lblLeftTitle.Font = $FontTitle
    $lblLeftTitle.Location = New-Object System.Drawing.Point(15, 10)
    $lblLeftTitle.Size = New-Object System.Drawing.Size(260, 25)
    $pnlLeft.Controls.Add($lblLeftTitle)

    $cmbMode = Add-ComboField "模式" 45 $Script:ModePresets 15 255
    $cmbMode.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList
    $cmbPlatform = Add-ComboField "平台模板" 45 $Script:PlatformPresets 295 255
    $cmbPlatform.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList


    $btnVideo = New-Object System.Windows.Forms.Button
    $btnVideo.Text = "影片製作"
    $btnVideo.Location = New-Object System.Drawing.Point(395, 10)
    $btnVideo.Size = New-Object System.Drawing.Size(155, 28)
    $btnVideo.Font = $FontLabel
    $btnVideo.BackColor = [System.Drawing.Color]::FromArgb(66, 153, 225)
    $btnVideo.ForeColor = [System.Drawing.Color]::White
    $btnVideo.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $btnVideo.FlatAppearance.BorderSize = 0
    $pnlLeft.Controls.Add($btnVideo)
    $btnVideo.Add_Click({ Show-VideoPromptEditor })

    $btnGenerate = New-Object System.Windows.Forms.Button
    $btnGenerate.Text = "產出提示詞"
    $btnGenerate.Location = New-Object System.Drawing.Point(15, 105)
    $btnGenerate.Size = New-Object System.Drawing.Size(365, 36)
    $btnGenerate.Font = $FontTitle
    $btnGenerate.BackColor = [System.Drawing.Color]::FromArgb(49, 151, 149)
    $btnGenerate.ForeColor = [System.Drawing.Color]::White
    $btnGenerate.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $btnGenerate.FlatAppearance.BorderSize = 0
    $pnlLeft.Controls.Add($btnGenerate)
    $btnClear = New-Object System.Windows.Forms.Button
    $btnClear.Text = "重設"
    $btnClear.Location = New-Object System.Drawing.Point(395, 105)
    $btnClear.Size = New-Object System.Drawing.Size(155, 36)
    $btnClear.Font = $FontLabel
    $btnClear.BackColor = [System.Drawing.Color]::FromArgb(226, 232, 240)
    $btnClear.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $btnClear.FlatAppearance.BorderSize = 0
    $pnlLeft.Controls.Add($btnClear)

    $txtSubject = Add-ComboField "1. 主體" 155 $Script:SubjectPresets 15 565
    $txtScene = Add-ComboField "2. 場景" 215 $Script:ScenePresets 15 275
    $txtAction = Add-ComboField "3. 動作" 215 $Script:ActionPresets 310 255
    $txtComposition = Add-ComboField "4. 構圖" 275 $Script:CompositionPresets 15 275
    $cmbCamera = Add-ComboField "5. 鏡頭" 275 $Script:CameraPresets 310 255
    $cmbLight = Add-ComboField "6. 光線" 335 $Script:LightPresets 15 275
    $txtMaterial = Add-ComboField "7. 材質" 335 $Script:MaterialPresets 310 255
    $txtColor = Add-ComboField "8. 色彩" 395 $Script:ColorPresets 15 275
    $cmbStyle = Add-ComboField "9. 風格" 395 @($Script:StylePresets.Keys) 310 255
    $cmbUseCase = Add-ComboField "10. 用途" 455 $Script:UseCasePresets 15 275
    $cmbRatio = Add-ComboField "11. 比例" 455 @($Script:RatioPresets.Keys) 310 255

    $lblQuality = New-Object System.Windows.Forms.Label
    $lblQuality.Text = "12. 品質要求"
    $lblQuality.Font = $FontLabel
    $lblQuality.Location = New-Object System.Drawing.Point(15, 515)
    $lblQuality.Size = New-Object System.Drawing.Size(275, 20)
    $pnlLeft.Controls.Add($lblQuality)
    $clbQuality = New-Object System.Windows.Forms.CheckedListBox
    $clbQuality.Location = New-Object System.Drawing.Point(15, 538)
    $clbQuality.Size = New-Object System.Drawing.Size(275, 135)
    $clbQuality.CheckOnClick = $true
    foreach ($Item in $Script:QualityItems) { [void]$clbQuality.Items.Add($Item) }
    for ($i = 0; $i -lt $clbQuality.Items.Count; $i++) { $clbQuality.SetItemChecked($i, $false) }
    $pnlLeft.Controls.Add($clbQuality)
    $lblNegative = New-Object System.Windows.Forms.Label
    $lblNegative.Text = "13. 排除條件"
    $lblNegative.Font = $FontLabel
    $lblNegative.Location = New-Object System.Drawing.Point(310, 515)
    $lblNegative.Size = New-Object System.Drawing.Size(255, 20)
    $pnlLeft.Controls.Add($lblNegative)
    $clbNegative = New-Object System.Windows.Forms.CheckedListBox
    $clbNegative.Location = New-Object System.Drawing.Point(310, 538)
    $clbNegative.Size = New-Object System.Drawing.Size(255, 135)
    $clbNegative.CheckOnClick = $true
    foreach ($Item in $Script:NegativeItems) { [void]$clbNegative.Items.Add($Item) }
    for ($i = 0; $i -lt $clbNegative.Items.Count; $i++) { $clbNegative.SetItemChecked($i, $true) }
    $pnlLeft.Controls.Add($clbNegative)

    $pnlRight = New-Object System.Windows.Forms.Panel
    $pnlRight.Location = New-Object System.Drawing.Point(655, 15)
    $pnlRight.Size = New-Object System.Drawing.Size(490, 700)
    $pnlRight.Anchor = [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Bottom -bor [System.Windows.Forms.AnchorStyles]::Left -bor [System.Windows.Forms.AnchorStyles]::Right
    $pnlRight.BackColor = [System.Drawing.Color]::White
    $form.Controls.Add($pnlRight)
    $lblRightTitle = New-Object System.Windows.Forms.Label
    $lblRightTitle.Text = "輸出預覽"
    $lblRightTitle.Font = $FontTitle
    $lblRightTitle.Location = New-Object System.Drawing.Point(15, 10)
    $lblRightTitle.Size = New-Object System.Drawing.Size(180, 30)
    $pnlRight.Controls.Add($lblRightTitle)
    $btnCopy = New-Object System.Windows.Forms.Button
    $btnCopy.Text = "複製"
    $btnCopy.Location = New-Object System.Drawing.Point(210, 8)
    $btnCopy.Size = New-Object System.Drawing.Size(130, 32)
    $btnCopy.Anchor = [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Right
    $btnCopy.Font = $FontLabel
    $btnCopy.BackColor = [System.Drawing.Color]::FromArgb(72, 187, 120)
    $btnCopy.ForeColor = [System.Drawing.Color]::White
    $btnCopy.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $btnCopy.FlatAppearance.BorderSize = 0
    $pnlRight.Controls.Add($btnCopy)
    $btnSave = New-Object System.Windows.Forms.Button
    $btnSave.Text = "另存 TXT"
    $btnSave.Location = New-Object System.Drawing.Point(345, 8)
    $btnSave.Size = New-Object System.Drawing.Size(130, 32)
    $btnSave.Anchor = [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Right
    $btnSave.Font = $FontLabel
    $btnSave.BackColor = [System.Drawing.Color]::FromArgb(237, 137, 54)
    $btnSave.ForeColor = [System.Drawing.Color]::White
    $btnSave.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $btnSave.FlatAppearance.BorderSize = 0
    $pnlRight.Controls.Add($btnSave)
    $txtOutput = New-Object System.Windows.Forms.TextBox
    $txtOutput.Multiline = $true
    $txtOutput.ScrollBars = [System.Windows.Forms.ScrollBars]::Vertical
    $txtOutput.Location = New-Object System.Drawing.Point(15, 50)
    $txtOutput.Size = New-Object System.Drawing.Size(460, 630)
    $txtOutput.Anchor = [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Bottom -bor [System.Windows.Forms.AnchorStyles]::Left -bor [System.Windows.Forms.AnchorStyles]::Right
    $txtOutput.ReadOnly = $false
    $txtOutput.Font = $FontCode
    $txtOutput.BackColor = [System.Drawing.Color]::FromArgb(247, 250, 252)
    $txtOutput.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle
    $pnlRight.Controls.Add($txtOutput)

    $InitialPreviewText = @"
【使用前先看】
一般模式只需要看：
1. ## 中文說明
2. ## Negative Prompt

============================================================
一、模式：你現在要做什麼
============================================================

1. 文生圖模式
   - 使用者只有文字想法，沒有原圖。
   - 目的：把 13 項欄位整理成高品質圖片生成 prompt。

2. 圖生圖模式
   - 使用者有參考圖。
   - 用途：依照原圖風格、構圖、人物、商品或氛圍，再生成新圖。

3. 修改/置換圖片模式
   - 使用者有原圖。
   - 用途：局部修改、換背景、換衣服、換物件、修臉、移除元素。

4. 圖生文模式
   - 使用者有圖片，想反推 prompt、分析畫面、產生描述文字。
   - 目的：把圖片轉成可重用的提示詞、商品描述、社群文案或分析說明。

5. 提示詞優化模式
   - 使用者已有 prompt，但想變得更清楚、更高品質、更適合某平台。
   - 目的：把原 prompt 改寫成平台可用版本，例如 Midjourney、SDXL、Flux、DALL·E。

============================================================
二、平台模板：最後要貼到哪裡用
============================================================

1. ChatGPT
   - 適合中文互動、圖片生成前的完整說明、改圖指令、提示詞優化。

2. Midjourney
   - 適合快速產生美術感強、風格化、商業視覺圖。

3. SDXL
   - 適合 Stable Diffusion / ComfyUI / Fooocus。
   - 尤其適合需要 Positive Prompt 與 Negative Prompt 分開時。

4. Flux
   - 適合 Flux 系列模型。
   - 偏向自然語句、準確描述、較少過度堆疊標籤。

5. DALL·E
   - 適合 OpenAI 圖片模型。
   - 尤其適合清楚、具體、遵守限制的自然語言描述。

============================================================
三、輸出預覽：產出後每段怎麼用
============================================================

1. ## 中文說明
   - 給使用者閱讀與確認需求。
   - 一般模式主要看這段即可。

2. ## Negative Prompt
   - 這是「不要出現什麼」的排除條件。
   - SDXL / Stable Diffusion 很常用。
   - Midjourney 可轉成 --no。
   - ChatGPT / DALL·E 可當成「避免」條件。
   - 幫助減少爛手、浮水印、變形、低品質。

3. ## English Prompt
   - 這是主要拿去生圖的英文提示詞。
   - 多數圖片模型對英文 prompt 支援最好。
   - 適合 Midjourney、SDXL、Flux、DALL·E。

4. ## JSON 結構化輸出
   - 給後續工具、API、自動化或二次編輯用。
   - 可用於：
     * 儲存專案
     * 載入上次設定
     * 批量生成
     * 接 API
     * 給其他程式讀取
     * 下一版擴充平台模板
"@
    $txtOutput.Text = $InitialPreviewText

    $btnGenerate.Add_Click({
        $Fields = @{ Subject = Get-SelectedText $txtSubject; Scene = Get-SelectedText $txtScene; Action = Get-SelectedText $txtAction; Composition = Get-SelectedText $txtComposition; Camera = Get-SelectedText $cmbCamera; Light = Get-SelectedText $cmbLight; Material = Get-SelectedText $txtMaterial; Color = Get-SelectedText $txtColor; Style = Get-SelectedText $cmbStyle; UseCase = Get-SelectedText $cmbUseCase; Ratio = Get-SelectedText $cmbRatio }
        $txtOutput.Text = Build-PromptDocument -Mode (Get-SelectedText $cmbMode) -Platform (Get-SelectedText $cmbPlatform) -Fields $Fields -Qualities (Get-CheckedTexts $clbQuality) -Negatives (Get-CheckedTexts $clbNegative)
    })
    $btnClear.Add_Click({ foreach ($Combo in @($txtSubject, $txtScene, $txtAction, $txtComposition, $cmbCamera, $cmbLight, $txtMaterial, $txtColor, $cmbStyle, $cmbUseCase, $cmbRatio)) { if ($Combo.Items.Count -gt 0) { $Combo.SelectedIndex = 0 }; $Combo.Text = "" }; $cmbMode.SelectedIndex = 0; $cmbPlatform.SelectedIndex = 0; $txtOutput.Text = $InitialPreviewText; for ($i = 0; $i -lt $clbQuality.Items.Count; $i++) { $clbQuality.SetItemChecked($i, $false) }; for ($i = 0; $i -lt $clbNegative.Items.Count; $i++) { $clbNegative.SetItemChecked($i, $true) } })
    $btnCopy.Add_Click({ if ([string]::IsNullOrWhiteSpace($txtOutput.Text)) { [System.Windows.Forms.MessageBox]::Show("目前沒有可複製的輸出，請先按「產出提示詞」。", "複製失敗", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information) } else { [System.Windows.Forms.Clipboard]::SetText($txtOutput.Text); [System.Windows.Forms.MessageBox]::Show("提示詞已複製到剪貼簿。", "複製成功", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information) } })
    $btnSave.Add_Click({
        if ([string]::IsNullOrWhiteSpace($txtOutput.Text)) { [System.Windows.Forms.MessageBox]::Show("目前沒有可匯出的輸出，請先按「產出提示詞」。", "匯出中止", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning); return }
        $SubjectText = (Get-SelectedText $txtSubject); $SafeSubject = if ($SubjectText.Length -gt 10) { $SubjectText.Substring(0, 10) } else { $SubjectText }
        foreach ($InvalidChar in [System.IO.Path]::GetInvalidFileNameChars()) { $SafeSubject = $SafeSubject.Replace([string]$InvalidChar, "") }
        $SafeSubject = $SafeSubject.Replace(" ", "").Replace("`r", "").Replace("`n", "")
        if ([string]::IsNullOrWhiteSpace($SafeSubject)) { $SafeSubject = "圖像提示詞" }
        $SaveDialog = New-Object System.Windows.Forms.SaveFileDialog; $SaveDialog.Filter = "純文字檔案 (*.txt)|*.txt"; $SaveDialog.Title = "將提示詞儲存為文字檔"; $SaveDialog.FileName = (Get-Date -Format "yyyyMMdd") + "_" + $SafeSubject + ".txt"

        if ($SaveDialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) { try { [System.IO.File]::WriteAllText($SaveDialog.FileName, $txtOutput.Text, [System.Text.Encoding]::UTF8); [System.Windows.Forms.MessageBox]::Show("檔案已成功寫入：" + [Environment]::NewLine + $SaveDialog.FileName, "匯出完成", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information) } catch { [System.Windows.Forms.MessageBox]::Show("寫入檔案時發生錯誤：" + [Environment]::NewLine + $_, "寫入失敗", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error) } }
    })

    [void]$form.ShowDialog()
} catch {
    Write-Host "============== 系統編譯嚴重錯誤 ==============" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Yellow
    Write-Host "===========================================" -ForegroundColor Red
    Read-Host "請按 Enter 鍵結束"
}
