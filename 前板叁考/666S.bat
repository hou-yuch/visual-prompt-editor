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


# ==============================================================================
# 🚀 AI 圖像提示詞建構師編輯器 (Standalone Stand-alone GUI Tool)
# ==============================================================================
# 技術規格：Windows PowerShell 5.1 / .NET Windows Forms / UTF-8 編碼安全保存
# ==============================================================================

try {
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    # --------------------------------------------------------------------------
    # 1. 內置靜態預設集資料庫 (零外部 JSON 依賴)
    # --------------------------------------------------------------------------
    
    # 畫風描述預設集 (風格 ➔ 英文原版特徵修飾字，最上方預留空白選項以利使用者「不選」)
    $Script:StylePresets = [ordered]@{
        ""                         = ""
        "寫實攝影 (Photorealistic)" = "Photorealistic, hyper-detailed, taken with 85mm lens, f/1.8, cinematic lighting, sharp focus, volumetric dust"
        "電影感 (Cinematic)"       = "Cinematic still, dramatic composition, anamorphic lens flare, moody atmosphere, highly professional color grading"
        "古風寫實 (Chinese Classical)" = "Traditional Chinese realistic painting style, classical elegance, fine brushwork, ink wash undertone, Zen aesthetic"
        "日系動漫 (Anime Style)"   = "Japanese anime style, clean and sharp line art, vibrant colors, beautiful sky composition, Kyoto Animation inspired"
        "水彩插畫 (Watercolor)"      = "Watercolor illustration, soft washes of color, hand-drawn paper textures, artistic paint splashes, whimsical feel"
        "經典油畫 (Oil Painting)"    = "Classic oil painting, textured brushstrokes, rich historical color palette, baroque art style, heavy impasto details"
        "國風插畫 (Modern Guofeng)" = "Modern Chinese Guofeng illustration, red and gold color scheme, mythical elements, decorative patterns, trendy art"
        "3D 渲染 (3D Render)"      = "3D render, Octane render, Ray tracing enabled, highly detailed, Unreal Engine 5 aesthetic, smooth materials"
        "商業產品攝影 (Studio)"    = "Commercial product photography, studio softbox lighting, clean studio background, reflections, sharp edges, professional look"
        "奇幻概念藝術 (Fantasy)"    = "Fantasy concept art, epic scale, mystical atmosphere, majestic structures, digital painting, legendary masterwork"
        "復古海報 (Retro Poster)"   = "Vintage poster style, retro textures, screen print effect, muted color palette, mid-century graphic design feel"
        "科幻電影風 (Sci-Fi)"       = "Sci-fi movie scene, futuristic technology, neon highlights, holographic elements, cyberpunk high-tech atmosphere"
        "蒸氣龐克 (Steampunk)"     = "Steampunk style, gears and brass, steam valves, Victorian machinery, intricate clockwork detailing, sepia tones"
        "像素藝術 (Pixel Art)"      = "Pixel art, retro 16-bit aesthetic, detailed sprite work, charming retro video game style, colorful blocks"
    }

    # 畫面比例規格對應表
    $Script:RatioPresets = [ordered]@{
        ""                     = ""
        "1:1 (社群頭像/商品)"  = "1:1"
        "16:9 (橫幅/電影感)"   = "16:9"
        "9:16 (直式海報/短影音)" = "9:16"
        "4:5 (Instagram 貼文)" = "4:5"
        "3:2 (專業單眼照)"     = "3:2"
    }

    # 光影氛圍設定預設集 (最上方預留空白選項以利使用者「不選」)
    $Script:LightPresets = @(
        "",
        "自然柔和光 (Soft Natural Light)",
        "黃金夕陽光 (Golden Hour Sunset)",
        "商業棚拍雙色調 (Dual Studio Lighting)",
        "側光強對比 (Dramatic Chiaroscuro Side Light)",
        "魔幻霓虹光 (Cyberpunk Neon Glow)",
        "林間漏光 (Dappled Sunlight through leaves)",
        "戲劇性頂光 (Dramatic Top Spotlight)",
        "無特定 (由 AI 專業圖像師合理補強)"
    )

    # 鏡頭相機視角設定 (最上方預留空白選項以利使用者「不選」)
    $Script:CameraPresets = @(
        "",
        "特寫鏡頭 (Close-up Shot)",
        "半身構圖 (Medium Shot)",
        "遠景全身 (Wide Angle Full Shot)",
        "低角度仰拍 (Low Angle Heroic View)",
        "俯瞰鳥瞰 (Top-down Bird's-eye View)",
        "宏偉極廣角 (Extreme Wide Landscape)",
        "無特定 (由 AI 專業圖像師合理補強)"
    )

    # 畫面用途預設集 (最上方預留空白選項以利使用者「不選」)
    $Script:UseCasePresets = @(
        "",
        "未指定 (由 AI 依主體特徵合理推估)",
        "社群平台貼文 (Social Media Post)",
        "書籍/網頁封面設計 (Cover Design)",
        "宣傳海報設計 (Poster & Banner)",
        "插畫藝術作品 (Artistic Illustration)",
        "商業產品展示圖 (Product Advertisement)"
    )

    # 品質要求 CheckedListBox 清單項目
    $Script:QualityItems = @(
        "高解析度 (Ultra HD)",
        "高細節 (Intricate Details)",
        "主體結構明確 (Sharp Focus on Subject)",
        "構圖平衡完整 (Perfect Composition)",
        "自然物理比例 (Realistic Proportions)",
        "畫面乾淨剔透 (Clean Rendering)",
        "材質紋理清楚 (Detailed Textures)",
        "色彩和諧協調 (Harmonious Color Palette)",
        "視覺焦點明確 (Clear Focal Point)"
    )

    # 負面提示詞 CheckedListBox 清單項目
    $Script:NegativeItems = @(
        "文字與浮水印 (Text, Watermarks)",
        "品牌標誌或 Logo (Logos, Brands)",
        "臉部變形扭曲 (Deformed Faces)",
        "多餘的肢體 (Extra Limbs)",
        "手部與手指畸形 (Deformed Hands/Fingers)",
        "模糊與低解析度 (Blurry, Low-res)",
        "雜亂搶焦的背景 (Cluttered Background)",
        "不自然且混亂的光影 (Unnatural Lighting)",
        "過度銳化與塑料感 (Oversharpened, Plasticy)"
    )

    # 操作模式預設集
    $Script:ModePresets = @(
        "生成新圖模式",
        "修改既有圖片模式",
        "提示詞優化模式"
    )

    # --------------------------------------------------------------------------
    # 2. 核心組裝引擎：將 GUI 參數封裝為 8 大模塊 Meta-Prompt
    # --------------------------------------------------------------------------
    Function Build-FinalPrompt {
        param(
            [string]$Mode,
            [string]$Subject,
            [string]$Action,
            [string]$Environment,
            [string]$Style,
            [string]$Ratio,
            [string]$Light,
            [string]$Camera,
            [string]$UseCase,
            [string]$Qualities,
            [string]$Negatives
        )

        $Out = New-Object System.Text.StringBuilder
        [void]$Out.AppendLine("# 666S 圖片提示詞任務")
        [void]$Out.AppendLine("模式：$Mode`r`n")

        switch -Wildcard ($Mode) {
            "修改既有圖片模式*" {
                [void]$Out.AppendLine("## 中文說明")
                [void]$Out.AppendLine("請根據使用者提供的既有圖片進行局部或整體修改，保留原圖中未被指定變更的主體特徵、構圖關係、光影方向與材質一致性。`r`n")
                [void]$Out.AppendLine("原圖/主體描述：`r`n$Subject`r`n")
                if ($Action) { [void]$Out.AppendLine("修改目標：`r`n$Action`r`n") }
                if ($Environment) { [void]$Out.AppendLine("需保留或調整的背景/材質：`r`n$Environment`r`n") }
                [void]$Out.AppendLine("## English Prompt")
                [void]$Out.AppendLine("Edit the provided image while preserving all unspecified visual elements. Apply the requested changes with coherent lighting, perspective, composition, and material consistency. Subject/reference: $Subject. Requested edit: $Action. Background/material notes: $Environment. Style: $Style. Lighting: $Light. Camera: $Camera. Aspect ratio: $Ratio. Quality requirements: $Qualities.`r`n")
            }
            "提示詞優化模式*" {
                [void]$Out.AppendLine("## 中文說明")
                [void]$Out.AppendLine("請將下方既有提示詞優化為更清楚、可執行、適合圖片生成平台使用的版本，保留原意並補強構圖、風格、光影、鏡頭、品質與排除條件。`r`n")
                [void]$Out.AppendLine("原始 Prompt / 想法：`r`n$Subject`r`n")
                if ($Action) { [void]$Out.AppendLine("優化方向：`r`n$Action`r`n") }
                if ($Environment) { [void]$Out.AppendLine("補充背景或限制：`r`n$Environment`r`n") }
                [void]$Out.AppendLine("## English Optimized Prompt")
                [void]$Out.AppendLine("Rewrite and enhance this image-generation prompt while preserving the original intent: $Subject. Optimization goal: $Action. Scene/background constraints: $Environment. Visual style: $Style. Lighting: $Light. Camera: $Camera. Aspect ratio: $Ratio. Quality requirements: $Qualities.`r`n")
            }
            default {
                [void]$Out.AppendLine("## 中文說明")
                [void]$Out.AppendLine("請生成一張高品質圖片。`r`n")
                [void]$Out.AppendLine("畫面主體：`r`n$Subject`r`n")
                if ($Action) { [void]$Out.AppendLine("主體動作：`r`n$Action`r`n") }
                if ($Environment) { [void]$Out.AppendLine("場景環境：`r`n$Environment`r`n") }
                [void]$Out.AppendLine("光影與鏡頭：`r`n$Light, $Camera, 畫面比例 $Ratio。`r`n")
                [void]$Out.AppendLine("藝術風格：`r`n$Style`r`n")
                [void]$Out.AppendLine("## English Prompt")
                [void]$Out.AppendLine("Create a high-quality image of $Subject. Action or pose: $Action. Environment and materials: $Environment. Style: $Style. Lighting: $Light. Camera: $Camera. Aspect ratio: $Ratio. Use case: $UseCase. Quality requirements: $Qualities.`r`n")
            }
        }

        [void]$Out.AppendLine("## Negative Prompt")
        if ($Negatives) {
            [void]$Out.AppendLine($Negatives)
        } else {
            [void]$Out.AppendLine("None")
        }

        [void]$Out.AppendLine("`r`n## JSON 結構化輸出")
$JsonPayload = [ordered]@{
            mode = $Mode
            subject = $Subject
            style = $Style
            ratio = $Ratio
            lighting = $Light
            camera = $Camera
            quality = $Qualities
            negative_prompt = $Negatives
        }
        [void]$Out.AppendLine(($JsonPayload | ConvertTo-Json -Depth 4))

        return $Out.ToString()
    }

    Function Build-MetaPrompt {
        param(
            [string]$Mode,
            [string]$Subject,
            [string]$Action,
            [string]$Environment,
            [string]$Style,
            [string]$Ratio,
            [string]$Light,
            [string]$Camera,
            [string]$UseCase,
            [string[]]$Qualities,
            [string[]]$Negatives
        )

        $ModeText = if (-not [string]::IsNullOrWhiteSpace($Mode)) { $Mode } else { "生成新圖模式" }
        $StyleDesc = if (-not [string]::IsNullOrWhiteSpace($Style)) { $Script:StylePresets[$Style] } else { "" }
        $RatioValue = if (-not [string]::IsNullOrWhiteSpace($Ratio)) { $Script:RatioPresets[$Ratio] } else { "" }
        $QualityText = if ($Qualities -and $Qualities.Count -gt 0) { $Qualities -join ", " } else { "" }
        $NegativeText = if ($Negatives -and $Negatives.Count -gt 0) { $Negatives -join ", " } else { "" }
        $LightText = if (-not [string]::IsNullOrWhiteSpace($Light)) { $Light } else { "由 AI 依主體與場景合理補強" }
        $CameraText = if (-not [string]::IsNullOrWhiteSpace($Camera)) { $Camera } else { "由 AI 依畫面用途合理選擇" }
        $RatioText = if (-not [string]::IsNullOrWhiteSpace($RatioValue)) { $RatioValue } else { "由 AI 依用途合理決定" }
        $StyleText = if (-not [string]::IsNullOrWhiteSpace($StyleDesc)) { $StyleDesc } else { "由 AI 依主體特徵合理補強" }
        $UseCaseText = if (-not [string]::IsNullOrWhiteSpace($UseCase)) { $UseCase } else { "未指定" }

        return Build-FinalPrompt `
            -Mode $ModeText `
            -Subject $Subject `
            -Action $Action `
            -Environment $Environment `
            -Style $StyleText `
            -Ratio $RatioText `
            -Light $LightText `
            -Camera $CameraText `
            -UseCase $UseCaseText `
            -Qualities $QualityText `
            -Negatives $NegativeText
    }

    # --------------------------------------------------------------------------
    # 3. GUI 介面佈局與視覺設計 (雙面板、高對比、對稱比例 Layout)
    # --------------------------------------------------------------------------
    $form = New-Object System.Windows.Forms.Form
    $form.Text = "AI 圖像提示詞建構師編輯器 (Standalone Version)"
    $form.Size = New-Object System.Drawing.Size(1150, 780)
    $form.StartPosition = "CenterScreen"
    $form.Font = New-Object System.Drawing.Font("Microsoft JhengHei UI", 10)
    $form.BackColor = [System.Drawing.Color]::FromArgb(245, 246, 248) # 專業淡雅灰，抗視覺疲勞

    # ==========================================================================
    # 🛠️ 核心修正：解決 WinForm .NET 限制
    # DoubleBuffered 是 Control 類別的 Protected（受保護）屬性。
    # 採用底層 .NET 反射 (Reflection) 技術強制解鎖存取權限。
    # ==========================================================================
    $form.GetType().GetProperty("DoubleBuffered", [System.Reflection.BindingFlags]"Instance, NonPublic").SetValue($form, $true, $null)

    # 字型預設值
    $FontTitle = New-Object System.Drawing.Font("Microsoft JhengHei UI", 12, [System.Drawing.FontStyle]::Bold)
    $FontLabel = New-Object System.Drawing.Font("Microsoft JhengHei UI", 10, [System.Drawing.FontStyle]::Bold)
    $FontNormal = New-Object System.Drawing.Font("Microsoft JhengHei UI", 10)
    $FontCode = New-Object System.Drawing.Font("Consolas", 10)

    # --------------------------------------------------------------------------
    # 3-1. 左側輸入區 Panel (Width: 540, Height: 710)
    # --------------------------------------------------------------------------
    $pnlLeft = New-Object System.Windows.Forms.Panel
    $pnlLeft.Location = New-Object System.Drawing.Point(15, 15)
    $pnlLeft.Size = New-Object System.Drawing.Size(540, 710)
    $pnlLeft.BackColor = [System.Drawing.Color]::White
    $form.Controls.Add($pnlLeft)

    # 左側標題
    $lblLeftTitle = New-Object System.Windows.Forms.Label
    $lblLeftTitle.Text = "🎨 圖像工程參數設定"
    $lblLeftTitle.Font = $FontTitle
    $lblLeftTitle.ForeColor = [System.Drawing.Color]::FromArgb(45, 55, 72)
    $lblLeftTitle.Location = New-Object System.Drawing.Point(15, 10)
    $lblLeftTitle.Size = New-Object System.Drawing.Size(250, 25)
    $pnlLeft.Controls.Add($lblLeftTitle)

    # 欄位 1: 畫面主體描述 (強打字框，必填)
    $lblSubject = New-Object System.Windows.Forms.Label
    $lblSubject.Text = "1. 畫面主體描述 (強制必填核心想法) *"
    $lblSubject.Font = $FontLabel
    $lblSubject.Location = New-Object System.Drawing.Point(15, 45)
    $lblSubject.Size = New-Object System.Drawing.Size(510, 20)
    $pnlLeft.Controls.Add($lblSubject)

    $txtSubject = New-Object System.Windows.Forms.TextBox
    $txtSubject.Multiline = $true
    $txtSubject.ScrollBars = [System.Windows.Forms.ScrollBars]::Vertical
    $txtSubject.Location = New-Object System.Drawing.Point(15, 65)
    $txtSubject.Size = New-Object System.Drawing.Size(510, 60)
    $txtSubject.Font = $FontNormal
    $pnlLeft.Controls.Add($txtSubject)

    # 欄位 2: 動作與姿態 (選填)
    $lblAction = New-Object System.Windows.Forms.Label
    $lblAction.Text = "2. 動作與姿態 (選填，留空則交由 AI 定向合理補全)"
    $lblAction.Font = $FontLabel
    $lblAction.Location = New-Object System.Drawing.Point(15, 135)
    $lblAction.Size = New-Object System.Drawing.Size(510, 20)
    $pnlLeft.Controls.Add($lblAction)

    $txtAction = New-Object System.Windows.Forms.TextBox
    $txtAction.Multiline = $true
    $txtAction.ScrollBars = [System.Windows.Forms.ScrollBars]::Vertical
    $txtAction.Location = New-Object System.Drawing.Point(15, 155)
    $txtAction.Size = New-Object System.Drawing.Size(510, 45)
    $txtAction.Font = $FontNormal
    $pnlLeft.Controls.Add($txtAction)

    # 欄位 3: 環境與材質 (選填)
    $lblEnvironment = New-Object System.Windows.Forms.Label
    $lblEnvironment.Text = "3. 環境背景與材質 (選填，留空則交由 AI 定向合理補全)"
    $lblEnvironment.Font = $FontLabel
    $lblEnvironment.Location = New-Object System.Drawing.Point(15, 210)
    $lblEnvironment.Size = New-Object System.Drawing.Size(510, 20)
    $pnlLeft.Controls.Add($lblEnvironment)

    $txtEnvironment = New-Object System.Windows.Forms.TextBox
    $txtEnvironment.Multiline = $true
    $txtEnvironment.ScrollBars = [System.Windows.Forms.ScrollBars]::Vertical
    $txtEnvironment.Location = New-Object System.Drawing.Point(15, 230)
    $txtEnvironment.Size = New-Object System.Drawing.Size(510, 45)
    $txtEnvironment.Font = $FontNormal
    $pnlLeft.Controls.Add($txtEnvironment)

    # -----------------
    # ComboBox 網格佈局 (支援空白不選機制)
    # -----------------

    # 畫面風格 (Style)
    $lblStyle = New-Object System.Windows.Forms.Label
    $lblStyle.Text = "畫面風格 (Style):"
    $lblStyle.Font = $FontLabel
    $lblStyle.Location = New-Object System.Drawing.Point(15, 285)
    $lblStyle.Size = New-Object System.Drawing.Size(240, 20)
    $pnlLeft.Controls.Add($lblStyle)

    $cmbStyle = New-Object System.Windows.Forms.ComboBox
    $cmbStyle.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList
    $cmbStyle.Location = New-Object System.Drawing.Point(15, 305)
    $cmbStyle.Size = New-Object System.Drawing.Size(240, 25)
    $cmbStyle.Font = $FontNormal
    foreach ($style in $Script:StylePresets.Keys) { [void]$cmbStyle.Items.Add($style) }
    $cmbStyle.SelectedIndex = 0
    $pnlLeft.Controls.Add($cmbStyle)

    # 畫面比例 (Ratio)
    $lblRatio = New-Object System.Windows.Forms.Label
    $lblRatio.Text = "畫面比例 (Ratio):"
    $lblRatio.Font = $FontLabel
    $lblRatio.Location = New-Object System.Drawing.Point(285, 285)
    $lblRatio.Size = New-Object System.Drawing.Size(240, 20)
    $pnlLeft.Controls.Add($lblRatio)

    $cmbRatio = New-Object System.Windows.Forms.ComboBox
    $cmbRatio.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList
    $cmbRatio.Location = New-Object System.Drawing.Point(285, 305)
    $cmbRatio.Size = New-Object System.Drawing.Size(240, 25)
    $cmbRatio.Font = $FontNormal
    foreach ($ratio in $Script:RatioPresets.Keys) { [void]$cmbRatio.Items.Add($ratio) }
    $cmbRatio.SelectedIndex = 0
    $pnlLeft.Controls.Add($cmbRatio)

    # 光影氛圍 (Lighting)
    $lblLight = New-Object System.Windows.Forms.Label
    $lblLight.Text = "光影設定 (Lighting):"
    $lblLight.Font = $FontLabel
    $lblLight.Location = New-Object System.Drawing.Point(15, 340)
    $lblLight.Size = New-Object System.Drawing.Size(240, 20)
    $pnlLeft.Controls.Add($lblLight)

    $cmbLight = New-Object System.Windows.Forms.ComboBox
    $cmbLight.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList
    $cmbLight.Location = New-Object System.Drawing.Point(15, 360)
    $cmbLight.Size = New-Object System.Drawing.Size(240, 25)
    $cmbLight.Font = $FontNormal
    foreach ($light in $Script:LightPresets) { [void]$cmbLight.Items.Add($light) }
    $cmbLight.SelectedIndex = 0
    $pnlLeft.Controls.Add($cmbLight)

    # 鏡頭視角 (Camera)
    $lblCamera = New-Object System.Windows.Forms.Label
    $lblCamera.Text = "鏡頭視角 (Camera):"
    $lblCamera.Font = $FontLabel
    $lblCamera.Location = New-Object System.Drawing.Point(285, 340)
    $lblCamera.Size = New-Object System.Drawing.Size(240, 20)
    $pnlLeft.Controls.Add($lblCamera)

    $cmbCamera = New-Object System.Windows.Forms.ComboBox
    $cmbCamera.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList
    $cmbCamera.Location = New-Object System.Drawing.Point(285, 360)
    $cmbCamera.Size = New-Object System.Drawing.Size(240, 25)
    $cmbCamera.Font = $FontNormal
    foreach ($cam in $Script:CameraPresets) { [void]$cmbCamera.Items.Add($cam) }
    $cmbCamera.SelectedIndex = 0
    $pnlLeft.Controls.Add($cmbCamera)

    # 畫面用途 (UseCase)
    $lblUseCase = New-Object System.Windows.Forms.Label
    $lblUseCase.Text = "畫面用途分類 (Use Case):"
    $lblUseCase.Font = $FontLabel
    $lblUseCase.Location = New-Object System.Drawing.Point(15, 395)
    $lblUseCase.Size = New-Object System.Drawing.Size(510, 20)
    $pnlLeft.Controls.Add($lblUseCase)

    $cmbUseCase = New-Object System.Windows.Forms.ComboBox
    $cmbUseCase.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList
    $cmbUseCase.Location = New-Object System.Drawing.Point(15, 415)
    $cmbUseCase.Size = New-Object System.Drawing.Size(510, 25)
    $cmbUseCase.Font = $FontNormal
    foreach ($case in $Script:UseCasePresets) { [void]$cmbUseCase.Items.Add($case) }
    $cmbUseCase.SelectedIndex = 0
    $pnlLeft.Controls.Add($cmbUseCase)

    # ------------------------------------------
    # CheckedListBox 品質要求與負面排除複選框
    # ------------------------------------------
    
    # 品質要求
    $lblQuality = New-Object System.Windows.Forms.Label
    $lblQuality.Text = "專屬品質控制標籤 (複選):"
    $lblQuality.Font = $FontLabel
    $lblQuality.Location = New-Object System.Drawing.Point(15, 450)
    $lblQuality.Size = New-Object System.Drawing.Size(240, 20)
    $pnlLeft.Controls.Add($lblQuality)

    $clbQuality = New-Object System.Windows.Forms.CheckedListBox
    $clbQuality.Location = New-Object System.Drawing.Point(15, 470)
    $clbQuality.Size = New-Object System.Drawing.Size(240, 140)
    $clbQuality.CheckOnClick = $true
    $clbQuality.Font = $FontNormal
    $clbQuality.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle
    foreach ($item in $Script:QualityItems) { [void]$clbQuality.Items.Add($item) }
    # 預設全勾選，提供最完美的預設畫質
    for ($i = 0; $i -lt $clbQuality.Items.Count; $i++) { $clbQuality.SetItemChecked($i, $true) }
    $pnlLeft.Controls.Add($clbQuality)

    # 負面提示排除
    $lblNegative = New-Object System.Windows.Forms.Label
    $lblNegative.Text = "負面提示排除項目 (複選):"
    $lblNegative.Font = $FontLabel
    $lblNegative.Location = New-Object System.Drawing.Point(285, 450)
    $lblNegative.Size = New-Object System.Drawing.Size(240, 20)
    $pnlLeft.Controls.Add($lblNegative)

    $clbNegative = New-Object System.Windows.Forms.CheckedListBox
    $clbNegative.Location = New-Object System.Drawing.Point(285, 470)
    $clbNegative.Size = New-Object System.Drawing.Size(240, 140)
    $clbNegative.CheckOnClick = $true
    $clbNegative.Font = $FontNormal
    $clbNegative.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle
    foreach ($item in $Script:NegativeItems) { [void]$clbNegative.Items.Add($item) }
    # 預設全勾選，提供最乾淨的防錯渲染
    for ($i = 0; $i -lt $clbNegative.Items.Count; $i++) { $clbNegative.SetItemChecked($i, $true) }
    $pnlLeft.Controls.Add($clbNegative)

    # 🚀 生成 & 🔄 清除 按鈕
    $btnGenerate = New-Object System.Windows.Forms.Button
    $btnGenerate.Text = "🚀 產出結構化 Meta-Prompt"
    $btnGenerate.Location = New-Object System.Drawing.Point(15, 640)
    $btnGenerate.Size = New-Object System.Drawing.Size(360, 45)
    $btnGenerate.Font = $FontTitle
    $btnGenerate.BackColor = [System.Drawing.Color]::FromArgb(49, 151, 149) # 深泰爾藍色
    $btnGenerate.ForeColor = [System.Drawing.Color]::White
    $btnGenerate.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $btnGenerate.FlatAppearance.BorderSize = 0
    $pnlLeft.Controls.Add($btnGenerate)

    $btnClear = New-Object System.Windows.Forms.Button
    $btnClear.Text = "🔄 重設清空"
    $btnClear.Location = New-Object System.Drawing.Point(390, 640)
    $btnClear.Size = New-Object System.Drawing.Size(135, 45)
    $btnClear.Font = $FontLabel
    $btnClear.BackColor = [System.Drawing.Color]::FromArgb(226, 232, 240)
    $btnClear.ForeColor = [System.Drawing.Color]::FromArgb(74, 85, 104)
    $btnClear.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $btnClear.FlatAppearance.BorderSize = 0
    $pnlLeft.Controls.Add($btnClear)

    # --------------------------------------------------------------------------
    # 3-2. 右側預覽區 Panel (Width: 540, Height: 710)
    # --------------------------------------------------------------------------
    $pnlRight = New-Object System.Windows.Forms.Panel
    $pnlRight.Location = New-Object System.Drawing.Point(575, 15)
    $pnlRight.Size = New-Object System.Drawing.Size(540, 710)
    $pnlRight.BackColor = [System.Drawing.Color]::White
    $form.Controls.Add($pnlRight)

    # 右側標題
    $lblRightTitle = New-Object System.Windows.Forms.Label
    $lblRightTitle.Text = "📋 結構化 Meta-Prompt 輸出預覽"
    $lblRightTitle.Font = $FontTitle
    $lblRightTitle.ForeColor = [System.Drawing.Color]::FromArgb(45, 55, 72)
    $lblRightTitle.Location = New-Object System.Drawing.Point(15, 10)
    $lblRightTitle.Size = New-Object System.Drawing.Size(250, 25)
    $pnlRight.Controls.Add($lblRightTitle)

    $lblMode = New-Object System.Windows.Forms.Label
    $lblMode.Text = "模式:"
    $lblMode.Font = $FontLabel
    $lblMode.Location = New-Object System.Drawing.Point(285, 12)
    $lblMode.Size = New-Object System.Drawing.Size(45, 20)
    $pnlRight.Controls.Add($lblMode)

    $cmbMode = New-Object System.Windows.Forms.ComboBox
    $cmbMode.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList
    $cmbMode.Location = New-Object System.Drawing.Point(335, 10)
    $cmbMode.Size = New-Object System.Drawing.Size(190, 25)
    $cmbMode.Font = $FontNormal
    foreach ($mode in $Script:ModePresets) { [void]$cmbMode.Items.Add($mode) }
    $cmbMode.SelectedIndex = 0
    $pnlRight.Controls.Add($cmbMode)

    # 輸出文字框 (開放編輯功能：移除唯讀狀態以利編輯)
    $txtOutput = New-Object System.Windows.Forms.TextBox
    $txtOutput.Multiline = $true
    $txtOutput.ScrollBars = [System.Windows.Forms.ScrollBars]::Vertical
    $txtOutput.Location = New-Object System.Drawing.Point(15, 45)
    $txtOutput.Size = New-Object System.Drawing.Size(510, 565)
    $txtOutput.ReadOnly = $false # 🛠️ 核心修正：改為可編輯模式
    $txtOutput.Font = $FontCode
    $txtOutput.BackColor = [System.Drawing.Color]::FromArgb(247, 250, 252) # 程式碼淺灰底
    $txtOutput.ForeColor = [System.Drawing.Color]::FromArgb(45, 55, 72)
    $txtOutput.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle
    $pnlRight.Controls.Add($txtOutput)

    # 📋 複製 & 💾 另存 按鈕
    $btnCopy = New-Object System.Windows.Forms.Button
    $btnCopy.Text = "📋 一鍵複製提示詞"
    $btnCopy.Location = New-Object System.Drawing.Point(15, 640)
    $btnCopy.Size = New-Object System.Drawing.Size(245, 45)
    $btnCopy.Font = $FontTitle
    $btnCopy.BackColor = [System.Drawing.Color]::FromArgb(72, 187, 120) # 溫和草綠色
    $btnCopy.ForeColor = [System.Drawing.Color]::White
    $btnCopy.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $btnCopy.FlatAppearance.BorderSize = 0
    $pnlRight.Controls.Add($btnCopy)

    $btnSave = New-Object System.Windows.Forms.Button
    $btnSave.Text = "💾 匯出另存 TXT"
    $btnSave.Location = New-Object System.Drawing.Point(280, 640)
    $btnSave.Size = New-Object System.Drawing.Size(245, 45)
    $btnSave.Font = $FontTitle
    $btnSave.BackColor = [System.Drawing.Color]::FromArgb(237, 137, 54) # 亮眼活力橘
    $btnSave.ForeColor = [System.Drawing.Color]::White
    $btnSave.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $btnSave.FlatAppearance.BorderSize = 0
    $pnlRight.Controls.Add($btnSave)

    # --------------------------------------------------------------------------
    # 4. 事件互動邏輯 (Event Handlers)
    # --------------------------------------------------------------------------

    # 1) 🚀 產出結構化 Meta-Prompt 邏輯
    $btnGenerate.Add_Click({
        # 強制檢核主體是否輸入 (安全防呆)
        $SubjectText = $txtSubject.Text.Trim()
        if ([string]::IsNullOrWhiteSpace($SubjectText)) {
            [System.Windows.Forms.MessageBox]::Show(
                "請輸入「1. 畫面主體描述」！此欄位為必填之畫面的核心靈魂。", 
                "欄位未填寫警告", 
                [System.Windows.Forms.MessageBoxButtons]::OK, 
                [System.Windows.Forms.MessageBoxIcon]::Warning
            )
            $txtSubject.Focus()
            return
        }

        # 安全抓取選取的項目 (防止 unselected 空值存取崩潰)
        $SelectedStyle = if ($null -ne $cmbStyle.SelectedItem) { $cmbStyle.SelectedItem.ToString() } else { "" }
        $SelectedRatio = if ($null -ne $cmbRatio.SelectedItem) { $cmbRatio.SelectedItem.ToString() } else { "" }
        $SelectedLight = if ($null -ne $cmbLight.SelectedItem) { $cmbLight.SelectedItem.ToString() } else { "" }
        $SelectedCamera = if ($null -ne $cmbCamera.SelectedItem) { $cmbCamera.SelectedItem.ToString() } else { "" }
        $SelectedUseCase = if ($null -ne $cmbUseCase.SelectedItem) { $cmbUseCase.SelectedItem.ToString() } else { "" }
        $SelectedMode = if ($null -ne $cmbMode.SelectedItem) { $cmbMode.SelectedItem.ToString() } else { "生成新圖模式" }

        # 收集選取的品質控制清單
        $SelectedQualities = New-Object System.Collections.Generic.List[string]
        foreach ($item in $clbQuality.CheckedItems) {
            # 僅萃取括號外的中文核心指標名稱，保持文字精煉
            $cleanName = $item.ToString() -split " " | Select-Object -First 1
            [void]$SelectedQualities.Add($cleanName)
        }

        # 收集選取的負面排除清單
        $SelectedNegatives = New-Object System.Collections.Generic.List[string]
        foreach ($item in $clbNegative.CheckedItems) {
            $cleanName = $item.ToString() -split " " | Select-Object -First 1
            [void]$SelectedNegatives.Add($cleanName)
        }

        # 呼叫中端動態組裝引擎
        $promptResult = Build-MetaPrompt `
            -Mode $SelectedMode `
            -Subject $SubjectText `
            -Action $txtAction.Text.Trim() `
            -Environment $txtEnvironment.Text.Trim() `
            -Style $SelectedStyle `
            -Ratio $SelectedRatio `
            -Light $SelectedLight `
            -Camera $SelectedCamera `
            -UseCase $SelectedUseCase `
            -Qualities $SelectedQualities.ToArray() `
            -Negatives $SelectedNegatives.ToArray()

        $txtOutput.Text = $promptResult
    })

    # 2) 🔄 重設清空功能
    $btnClear.Add_Click({
        $txtSubject.Clear()
        $txtAction.Clear()
        $txtEnvironment.Clear()
        $txtOutput.Clear()
        
        $cmbStyle.SelectedIndex = 0
        $cmbRatio.SelectedIndex = 0
        $cmbLight.SelectedIndex = 0
        $cmbCamera.SelectedIndex = 0
        $cmbUseCase.SelectedIndex = 0
        $cmbMode.SelectedIndex = 0

        # 將 CheckedListBox 重置為全選狀態
        for ($i = 0; $i -lt $clbQuality.Items.Count; $i++) { $clbQuality.SetItemChecked($i, $true) }
        for ($i = 0; $i -lt $clbNegative.Items.Count; $i++) { $clbNegative.SetItemChecked($i, $true) }
    })

    # 3) 📋 一鍵複製至剪貼簿
    $btnCopy.Add_Click({
        if ([string]::IsNullOrWhiteSpace($txtOutput.Text)) {
            [System.Windows.Forms.MessageBox]::Show(
                "目前預覽區尚無內容！請先在左側輸入並點擊「🚀 產出結構化 Meta-Prompt」。", 
                "複製失敗", 
                [System.Windows.Forms.MessageBoxButtons]::OK, 
                [System.Windows.Forms.MessageBoxIcon]::Information
            )
        } else {
            # 寫入系統剪貼簿
            [System.Windows.Forms.Clipboard]::SetText($txtOutput.Text)
            [System.Windows.Forms.MessageBox]::Show(
                "結構化 Meta-Prompt 已成功複製到剪貼簿！`n您可以直接貼到 ChatGPT 或 Claude 對話框中，AI 將嚴格依此大師級 SOP 為您展開提示詞。", 
                "複製成功", 
                [System.Windows.Forms.MessageBoxButtons]::OK, 
                [System.Windows.Forms.MessageBoxIcon]::Information
            )
        }
    })

    # 4) 💾 一鍵另存檔案 (安全防錯 UTF-8 寫入與智慧命名)
    $btnSave.Add_Click({
        if ([string]::IsNullOrWhiteSpace($txtOutput.Text)) {
            [System.Windows.Forms.MessageBox]::Show(
                "目前預覽區尚無內容可供匯出！", 
                "匯出中止", 
                [System.Windows.Forms.MessageBoxButtons]::OK, 
                [System.Windows.Forms.MessageBoxIcon]::Warning
            )
            return
        }

        # 智慧檔名生成：[當前日期]_[畫面主體描述前10字]_AI提示詞.txt
        $SubjectText = $txtSubject.Text.Trim()
        $SafeSubject = if ($SubjectText.Length -gt 10) { $SubjectText.Substring(0, 10) } else { $SubjectText }
        
        # 過濾檔案系統不合法的特殊符號
        $InvalidChars = [System.IO.Path]::GetInvalidFileNameChars()
        foreach ($char in $InvalidChars) {
            $SafeSubject = $SafeSubject.Replace($char, "")
        }
        $SafeSubject = $SafeSubject.Replace(" ", "").Replace("`r", "").Replace("`n", "")
        
        if ([string]::IsNullOrWhiteSpace($SafeSubject)) { $SafeSubject = "圖像提示詞" }
        $DateString = Get-Date -Format "yyyyMMdd"
        $DefaultFileName = "${DateString}_${SafeSubject}_AI提示詞.txt"

        $SaveDialog = New-Object System.Windows.Forms.SaveFileDialog
        $SaveDialog.Filter = "純文字檔案 (*.txt)|*.txt"
        $SaveDialog.Title = "將提示詞說明書儲存為文字檔"
        $SaveDialog.FileName = $DefaultFileName

        if ($SaveDialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
            try {
                # 採用強固的 .NET UTF8 無損編碼寫入，避免 PowerShell 5.1 原生 Out-File 的 Big Endian Unicode 亂碼 Bug
                [System.IO.File]::WriteAllText($SaveDialog.FileName, $txtOutput.Text, [System.Text.Encoding]::UTF8)
                
                [System.Windows.Forms.MessageBox]::Show(
                    "檔案已成功以標準 UTF-8 編碼安全寫入：`n$($SaveDialog.FileName)", 
                    "匯出完成", 
                    [System.Windows.Forms.MessageBoxButtons]::OK, 
                    [System.Windows.Forms.MessageBoxIcon]::Information
                )
            } catch {
                [System.Windows.Forms.MessageBox]::Show(
                    "寫入檔案時發生系統權限或路徑錯誤！`n原因: $_", 
                    "寫入失敗", 
                    [System.Windows.Forms.MessageBoxButtons]::OK, 
                    [System.Windows.Forms.MessageBoxIcon]::Error
                )
            }
        }
    })

    # --------------------------------------------------------------------------
    # 5. 表單顯示啟動
    # --------------------------------------------------------------------------
    [void]$form.ShowDialog()

} catch {
    Write-Host "============== 系統編譯嚴重錯誤 ==============" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Yellow
    Write-Host "===========================================" -ForegroundColor Red
    Read-Host "請按 Enter 鍵結束"
}
