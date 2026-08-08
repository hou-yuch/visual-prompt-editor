<# :

@echo off  

cd /d "%~dp0"



:: 自動提權

fltmc >nul 2>&1 || (

    PowerShell Start-Process -FilePath "%0" -Verb RunAs

    exit /b

)



:: 執行 PowerShell (指定 UTF8)，並將本檔完整路徑傳入 PowerShell 區塊
powershell -NoProfile -ExecutionPolicy Bypass -Command "$Script:SourceFilePath = '%~f0'; Invoke-Expression ([System.IO.File]::ReadAllText($Script:SourceFilePath, [System.Text.Encoding]::UTF8))"


echo 按任意鍵退出 --------
Pause>nul

exit /b   

#>

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
        $Out = New-Object System.Text.StringBuilder
        [void]$Out.AppendLine("圖片提示詞任務")
        [void]$Out.AppendLine("模式：$Mode")
        [void]$Out.AppendLine("平台模板：$Platform")
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
