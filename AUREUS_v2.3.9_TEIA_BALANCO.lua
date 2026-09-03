--// AUREUS v2.3.9
--// Painel vermelho compacto, arrastável, com scroll e botão ORG minimizado

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local OldGui = PlayerGui:FindFirstChild("AUREUS_UI")
if OldGui then
	OldGui:Destroy()
end

local VERSION = "v1.0.0"

local Colors = {
	Background = Color3.fromRGB(20, 21, 25),
	Topbar = Color3.fromRGB(28, 29, 34),
	Sidebar = Color3.fromRGB(25, 26, 31),
	Content = Color3.fromRGB(22, 23, 28),
	Card = Color3.fromRGB(32, 33, 39),
	CardHover = Color3.fromRGB(40, 41, 48),
	Red = Color3.fromRGB(220, 55, 65),
	RedDark = Color3.fromRGB(160, 35, 45),
	Text = Color3.fromRGB(230, 230, 235),
	SubText = Color3.fromRGB(130, 132, 140),
	Border = Color3.fromRGB(55, 56, 64),
	Error = Color3.fromRGB(255, 80, 80),
	Success = Color3.fromRGB(100, 220, 130)
}

local function Tween(Object, Properties, Duration)
	local Success, Result = pcall(function()
		local Animation = TweenService:Create(
			Object,
			TweenInfo.new(Duration or 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			Properties
		)
		Animation:Play()
		return Animation
	end)
	if Success then return Result end
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AUREUS_UI"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

local Main = Instance.new("Frame")
Main.Name = "AUREUS"
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.Size = UDim2.new(0, 580, 0, 370)
Main.BackgroundColor3 = Colors.Background
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = ScreenGui

local MainConstraint = Instance.new("UISizeConstraint")
MainConstraint.MinSize = Vector2.new(360, 260)
MainConstraint.MaxSize = Vector2.new(620, 400)
MainConstraint.Parent = Main

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 7)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Colors.Border
MainStroke.Thickness = 1
MainStroke.Parent = Main

local Topbar = Instance.new("Frame")
Topbar.Size = UDim2.new(1, 0, 0, 55)
Topbar.BackgroundColor3 = Colors.Topbar
Topbar.BorderSizePixel = 0
Topbar.Parent = Main

local TopLine = Instance.new("Frame")
TopLine.AnchorPoint = Vector2.new(0, 1)
TopLine.Position = UDim2.new(0, 0, 1, 0)
TopLine.Size = UDim2.new(1, 0, 0, 1)
TopLine.BackgroundColor3 = Colors.Border
TopLine.BorderSizePixel = 0
TopLine.Parent = Topbar

local Title = Instance.new("TextLabel")
Title.Position = UDim2.new(0, 18, 0, 0)
Title.Size = UDim2.new(1, -150, 1, 0)
Title.BackgroundTransparency = 1
Title.RichText = true
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Text = '<font color="rgb(220,55,65)">AUREUS</font> <font color="rgb(190,190,195)">v1.0.0</font>'
Title.TextColor3 = Colors.Text
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.Parent = Topbar

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.AnchorPoint = Vector2.new(1, 0.5)
MinimizeButton.Position = UDim2.new(1, -70, 0.5, 0)
MinimizeButton.Size = UDim2.new(0, 40, 0, 32)
MinimizeButton.BackgroundColor3 = Colors.Card
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Text = "−"
MinimizeButton.TextColor3 = Colors.Text
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 22
MinimizeButton.Parent = Topbar

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 5)
MinimizeCorner.Parent = MinimizeButton

local CloseButton = Instance.new("TextButton")
CloseButton.AnchorPoint = Vector2.new(1, 0.5)
CloseButton.Position = UDim2.new(1, -18, 0.5, 0)
CloseButton.Size = UDim2.new(0, 40, 0, 32)
CloseButton.BackgroundColor3 = Colors.Card
CloseButton.BorderSizePixel = 0
CloseButton.Text = "×"
CloseButton.TextColor3 = Colors.Text
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 22
CloseButton.Parent = Topbar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 5)
CloseCorner.Parent = CloseButton

local Body = Instance.new("Frame")
Body.Position = UDim2.new(0, 0, 0, 55)
Body.Size = UDim2.new(1, 0, 1, -55)
Body.BackgroundTransparency = 1
Body.Parent = Main

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 165, 1, 0)
Sidebar.BackgroundColor3 = Colors.Sidebar
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Body

local SidebarLine = Instance.new("Frame")
SidebarLine.AnchorPoint = Vector2.new(1, 0)
SidebarLine.Position = UDim2.new(1, 0, 0, 0)
SidebarLine.Size = UDim2.new(0, 1, 1, 0)
SidebarLine.BackgroundColor3 = Colors.Border
SidebarLine.BorderSizePixel = 0
SidebarLine.Parent = Sidebar

local PagesTitle = Instance.new("TextLabel")
PagesTitle.Position = UDim2.new(0, 25, 0, 12)
PagesTitle.Size = UDim2.new(1, -30, 0, 35)
PagesTitle.BackgroundTransparency = 1
PagesTitle.Text = "PAGES"
PagesTitle.TextColor3 = Colors.SubText
PagesTitle.Font = Enum.Font.GothamBold
PagesTitle.TextSize = 16
PagesTitle.TextXAlignment = Enum.TextXAlignment.Left
PagesTitle.Parent = Sidebar

local MenuScroll = Instance.new("ScrollingFrame")
MenuScroll.Position = UDim2.new(0, 0, 0, 50)
MenuScroll.Size = UDim2.new(1, 0, 1, -50)
MenuScroll.BackgroundTransparency = 1
MenuScroll.BorderSizePixel = 0
MenuScroll.ScrollBarThickness = 3
MenuScroll.ScrollBarImageColor3 = Colors.Red
MenuScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
MenuScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
MenuScroll.Parent = Sidebar

local MenuLayout = Instance.new("UIListLayout")
MenuLayout.Padding = UDim.new(0, 3)
MenuLayout.SortOrder = Enum.SortOrder.LayoutOrder
MenuLayout.Parent = MenuScroll

local Content = Instance.new("Frame")
Content.Position = UDim2.new(0, 165, 0, 0)
Content.Size = UDim2.new(1, -165, 1, 0)
Content.BackgroundColor3 = Colors.Content
Content.BorderSizePixel = 0
Content.ClipsDescendants = true
Content.Parent = Body

local ContentHeader = Instance.new("TextLabel")
ContentHeader.Position = UDim2.new(0, 25, 0, 12)
ContentHeader.Size = UDim2.new(1, -50, 0, 35)
ContentHeader.BackgroundTransparency = 1
ContentHeader.Text = "HOME"
ContentHeader.TextColor3 = Colors.SubText
ContentHeader.Font = Enum.Font.GothamBold
ContentHeader.TextSize = 16
ContentHeader.TextXAlignment = Enum.TextXAlignment.Left
ContentHeader.Parent = Content

local HeaderLine = Instance.new("Frame")
HeaderLine.AnchorPoint = Vector2.new(0, 1)
HeaderLine.Position = UDim2.new(0, 0, 0, 50)
HeaderLine.Size = UDim2.new(1, 0, 0, 1)
HeaderLine.BackgroundColor3 = Colors.Border
HeaderLine.BorderSizePixel = 0
HeaderLine.Parent = Content

local PageContainer = Instance.new("Frame")
PageContainer.Position = UDim2.new(0, 0, 0, 51)
PageContainer.Size = UDim2.new(1, 0, 1, -51)
PageContainer.BackgroundTransparency = 1
PageContainer.ClipsDescendants = true
PageContainer.Parent = Content

local Pages = {}
local MenuButtons = {}
local CurrentPage

local function CreatePage(Name)
	local Page = Instance.new("ScrollingFrame")
	Page.Name = Name
	Page.Size = UDim2.fromScale(1, 1)
	Page.BackgroundTransparency = 1
	Page.BorderSizePixel = 0
	Page.Visible = false
	Page.ScrollBarThickness = 4
	Page.ScrollBarImageColor3 = Colors.Red
	Page.CanvasSize = UDim2.new(0, 0, 0, 0)
	Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
	Page.Position = UDim2.new(0, 0, 0, 0)
	Page.Parent = PageContainer

	local Padding = Instance.new("UIPadding")
	Padding.PaddingLeft = UDim.new(0, 20)
	Padding.PaddingRight = UDim.new(0, 20)
	Padding.PaddingTop = UDim.new(0, 15)
	Padding.PaddingBottom = UDim.new(0, 20)
	Padding.Parent = Page

	local Layout = Instance.new("UIListLayout")
	Layout.Padding = UDim.new(0, 10)
	Layout.SortOrder = Enum.SortOrder.LayoutOrder
	Layout.Parent = Page

	Pages[Name] = Page
	return Page
end

local function CreateCard(Page, Height)
	local Card = Instance.new("Frame")
	Card.Size = UDim2.new(1, -5, 0, Height)
	Card.BackgroundColor3 = Colors.Card
	Card.BorderSizePixel = 0
	Card.Parent = Page

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0, 6)
	Corner.Parent = Card

	local Stroke = Instance.new("UIStroke")
	Stroke.Color = Colors.Border
	Stroke.Thickness = 1
	Stroke.Parent = Card
	return Card
end

local function CreateLabel(Parent, Text, Position, Size, Color, TextSize)
	local Label = Instance.new("TextLabel")
	Label.Position = Position
	Label.Size = Size
	Label.BackgroundTransparency = 1
	Label.Text = Text
	Label.TextColor3 = Color or Colors.Text
	Label.Font = Enum.Font.Gotham
	Label.TextSize = TextSize or 14
	Label.TextXAlignment = Enum.TextXAlignment.Left
	Label.TextWrapped = true
	Label.Parent = Parent
	return Label
end

local function CreateButton(Parent, Text, Position, Size)
	local Button = Instance.new("TextButton")
	Button.Position = Position
	Button.Size = Size
	Button.BackgroundColor3 = Colors.Red
	Button.BorderSizePixel = 0
	Button.Text = Text
	Button.TextColor3 = Color3.fromRGB(255, 255, 255)
	Button.Font = Enum.Font.GothamBold
	Button.TextSize = 13
	Button.AutoButtonColor = false
	Button.Parent = Parent

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0, 5)
	Corner.Parent = Button

	Button.MouseEnter:Connect(function()
		Tween(Button, {BackgroundColor3 = Colors.RedDark})
	end)

	Button.MouseLeave:Connect(function()
		Tween(Button, {BackgroundColor3 = Colors.Red})
	end)
	return Button
end

local HomePage = CreatePage("Home")
local LocalPlayerPage = CreatePage("Local Player")
local ExecutorPage = CreatePage("Executor")
local ScriptsPage = CreatePage("Scripts")
local FriendsPage = CreatePage("Amigos")
local GearPage = CreatePage("Gear")
local PlayersPage = CreatePage("Players")

local HomeCard = CreateCard(HomePage, 230)
CreateLabel(HomeCard, "AUREUS HOME", UDim2.new(0,18,0,12), UDim2.new(1,-36,0,30), Colors.Red, 17)

local Status = CreateLabel(HomeCard, "Status: Pronto", UDim2.new(0,18,0,48), UDim2.new(1,-36,0,25), Colors.SubText, 13)

local BanButton = CreateButton(HomeCard, "CARREGAR BAN HAMMER", UDim2.new(0,18,0,82), UDim2.new(1,-36,0,42))

BanButton.MouseButton1Click:Connect(function()
	Status.Text = "Status: Carregando..."
	Status.TextColor3 = Colors.SubText

	local Success, Result = pcall(function()
		loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Ban-Hammer-Script-58232"))()
	end)

	if Success then
		Status.Text = "Status: Carregado!"
		Status.TextColor3 = Colors.Success
		BanButton.Text = "BAN HAMMER CARREGADO"
	else
		Status.Text = "Status: Erro"
		Status.TextColor3 = Colors.Error
		warn(Result)
	end
end)

local BoostButton = CreateButton(HomeCard, "DAR AUREUS BOOST", UDim2.new(0,18,0,135), UDim2.new(1,-36,0,42))
CreateLabel(HomeCard, "Equipado: Velocidade 50 • Pulo 44", UDim2.new(0,18,0,185), UDim2.new(1,-36,0,25), Colors.SubText, 12)

BoostButton.MouseButton1Click:Connect(function()
	local Success, ErrorMessage = pcall(function()
		local Character = Player.Character or Player.CharacterAdded:Wait()
		local Backpack = Player:WaitForChild("Backpack")

		if Backpack:FindFirstChild("AUREUS Boost") or Character:FindFirstChild("AUREUS Boost") then
			Status.Text = "Status: Item já existe"
			Status.TextColor3 = Colors.SubText
			return
		end

		local Tool = Instance.new("Tool")
		Tool.Name = "AUREUS Boost"
		Tool.RequiresHandle = false
		Tool.CanBeDropped = false
		Tool.ToolTip = "Velocidade 50 | Pulo 44"

		local OriginalSpeed = 16
		local OriginalJump = 50

		Tool.Equipped:Connect(function()
			local CharacterNow = Player.Character
			if not CharacterNow then return end
			local Humanoid = CharacterNow:FindFirstChildOfClass("Humanoid")
			if not Humanoid then return end

			OriginalSpeed = Humanoid.WalkSpeed
			OriginalJump = Humanoid.JumpPower
			Humanoid.UseJumpPower = true
			Humanoid.WalkSpeed = 50
			Humanoid.JumpPower = 44
		end)

		Tool.Unequipped:Connect(function()
			local CharacterNow = Player.Character
			if not CharacterNow then return end
			local Humanoid = CharacterNow:FindFirstChildOfClass("Humanoid")
			if Humanoid then
				Humanoid.WalkSpeed = OriginalSpeed
				Humanoid.JumpPower = OriginalJump
			end
		end)

		Tool.Parent = Backpack
		Status.Text = "Status: AUREUS Boost recebido!"
		Status.TextColor3 = Colors.Success
	end)

	if not Success then
		Status.Text = "Status: Erro ao criar item"
		Status.TextColor3 = Colors.Error
		warn(ErrorMessage)
	end
end)


local LocalCard = CreateCard(LocalPlayerPage, 140)
CreateLabel(LocalCard, "LOCAL PLAYER", UDim2.new(0,18,0,15), UDim2.new(1,-36,0,30), Colors.Red, 17)
CreateLabel(LocalCard, "Área preparada para futuras funções do jogador.", UDim2.new(0,18,0,55), UDim2.new(1,-36,0,55), Colors.SubText, 13)

local ExecutorCard = CreateCard(ExecutorPage, 280)
CreateLabel(ExecutorCard, "LOADSTRING EXECUTOR", UDim2.new(0,18,0,12), UDim2.new(1,-36,0,30), Colors.Red, 17)

local ExecutorStatus = CreateLabel(ExecutorCard, "Pronto para executar código Lua.", UDim2.new(0,18,0,45), UDim2.new(1,-36,0,25), Colors.SubText, 12)

local CodeBox = Instance.new("TextBox")
CodeBox.Position = UDim2.new(0,18,0,78)
CodeBox.Size = UDim2.new(1,-36,0,120)
CodeBox.BackgroundColor3 = Color3.fromRGB(18,19,23)
CodeBox.BorderSizePixel = 0
CodeBox.TextColor3 = Colors.Text
CodeBox.PlaceholderColor3 = Color3.fromRGB(100,102,110)
CodeBox.PlaceholderText = 'loadstring(game:HttpGet("URL"))()'
CodeBox.Text = ""
CodeBox.ClearTextOnFocus = false
CodeBox.MultiLine = true
CodeBox.TextWrapped = true
CodeBox.TextXAlignment = Enum.TextXAlignment.Left
CodeBox.TextYAlignment = Enum.TextYAlignment.Top
CodeBox.Font = Enum.Font.Code
CodeBox.TextSize = 12
CodeBox.Parent = ExecutorCard

local CodeCorner = Instance.new("UICorner")
CodeCorner.CornerRadius = UDim.new(0,5)
CodeCorner.Parent = CodeBox

local CodePadding = Instance.new("UIPadding")
CodePadding.PaddingLeft = UDim.new(0,8)
CodePadding.PaddingRight = UDim.new(0,8)
CodePadding.PaddingTop = UDim.new(0,8)
CodePadding.PaddingBottom = UDim.new(0,8)
CodePadding.Parent = CodeBox

local RunButton = CreateButton(ExecutorCard, "EXECUTAR", UDim2.new(0,18,0,212), UDim2.new(1,-36,0,42))

RunButton.MouseButton1Click:Connect(function()
	local Code = CodeBox.Text
	if Code == "" or Code:gsub("%s", "") == "" then
		ExecutorStatus.Text = "Digite algum código."
		ExecutorStatus.TextColor3 = Colors.Error
		return
	end

	ExecutorStatus.Text = "Executando..."
	ExecutorStatus.TextColor3 = Colors.SubText

	local Success, Result = pcall(function()
		if type(loadstring) ~= "function" then
			error("loadstring não está disponível neste ambiente.")
		end
		local Function, CompileError = loadstring(Code)
		if not Function then error(CompileError) end
		return Function()
	end)

	if Success then
		ExecutorStatus.Text = "Executado com sucesso!"
		ExecutorStatus.TextColor3 = Colors.Success
	else
		ExecutorStatus.Text = "Erro: " .. tostring(Result)
		ExecutorStatus.TextColor3 = Colors.Error
		warn("[AUREUS Executor]", Result)
	end
end)

for i = 1, 6 do
	local Card = CreateCard(ScriptsPage, 75)
	CreateLabel(Card, "SCRIPT SLOT " .. i, UDim2.new(0,15,0,10), UDim2.new(1,-30,0,25), Colors.Text, 14)
	CreateLabel(Card, "Espaço disponível para futuras funções.", UDim2.new(0,15,0,38), UDim2.new(1,-30,0,25), Colors.SubText, 12)
end


--// ABA AMIGOS

local FriendsCard = CreateCard(FriendsPage, 210)

CreateLabel(FriendsCard, "AMIGOS", UDim2.new(0,18,0,12), UDim2.new(1,-36,0,28), Colors.Red, 17)

local FriendInput = Instance.new("TextBox")
FriendInput.Name = "FriendNameInput"
FriendInput.Position = UDim2.new(0,18,0,52)
FriendInput.Size = UDim2.new(1,-36,0,42)
FriendInput.BackgroundColor3 = Color3.fromRGB(22, 24, 31)
FriendInput.BorderSizePixel = 0
FriendInput.PlaceholderText = "Digite o nome do jogador..."
FriendInput.PlaceholderColor3 = Colors.SubText
FriendInput.Text = ""
FriendInput.TextColor3 = Colors.Text
FriendInput.TextSize = 14
FriendInput.Font = Enum.Font.Gotham
FriendInput.ClearTextOnFocus = false
FriendInput.Parent = FriendsCard

local FriendInputCorner = Instance.new("UICorner")
FriendInputCorner.CornerRadius = UDim.new(0, 6)
FriendInputCorner.Parent = FriendInput

local FriendInputStroke = Instance.new("UIStroke")
FriendInputStroke.Color = Color3.fromRGB(55, 58, 70)
FriendInputStroke.Thickness = 1
FriendInputStroke.Parent = FriendInput

local FriendsStatus = CreateLabel(
	FriendsCard,
	"Digite o nome de um jogador.",
	UDim2.new(0,18,0,104),
	UDim2.new(1,-36,0,22),
	Colors.SubText,
	12
)

local KillSelectedFriendButton = CreateButton(
	FriendsCard,
	"ELIMINAR AMIGO",
	UDim2.new(0,18,0,142),
	UDim2.new(1,-36,0,42)
)

KillSelectedFriendButton.MouseButton1Click:Connect(function()
	local Success, Result = pcall(function()
		local Name = string.gsub(FriendInput.Text or "", "^%s*(.-)%s*$", "%1")

		if Name == "" then
			error("Digite um nome.")
		end

		local Target = nil
		for _, Candidate in ipairs(Players:GetPlayers()) do
			if Candidate.Name:lower() == Name:lower()
				or Candidate.DisplayName:lower() == Name:lower() then
				Target = Candidate
				break
			end
		end

		if not Target then
			error("Jogador não encontrado no servidor.")
		end

		if Target == Player then
			error("Escolha outro jogador.")
		end

		local IsFriendSuccess, IsFriend = pcall(function()
			return Player:IsFriendsWith(Target.UserId)
		end)

		if not IsFriendSuccess or not IsFriend then
			error("O jogador selecionado não está na sua lista de amigos.")
		end

		local Remote = ReplicatedStorage:FindFirstChild("AUREUS_KillFriend")
		if not Remote or not Remote:IsA("RemoteEvent") then
			error("RemoteEvent AUREUS_KillFriend não encontrado.")
		end

		Remote:FireServer(Target.UserId)
		return Target.Name
	end)

	if Success then
		FriendsStatus.Text = "Solicitação enviada para " .. tostring(Result) .. "."
		FriendsStatus.TextColor3 = Colors.Success
	else
		FriendsStatus.Text = "Erro: " .. tostring(Result)
		FriendsStatus.TextColor3 = Colors.Error
		warn("[AUREUS Amigos]", Result)
	end
end)





--// HOME / MAIN: MINI PAINEL DE MOVIMENTO
--// Usa MouseBehavior para o modo de mira central e solicita ao servidor
--// a ativação de uma área/função de passagem autorizada pelo próprio jogo.

local WallMiniButtonCard = CreateCard(HomePage, 105)
CreateLabel(WallMiniButtonCard, "MOVIMENTO", UDim2.new(0,18,0,12), UDim2.new(1,-36,0,26), Colors.Red, 17)
CreateLabel(
    WallMiniButtonCard,
    "Abra o mini painel de movimento.",
    UDim2.new(0,18,0,42),
    UDim2.new(1,-36,0,20),
    Colors.SubText,
    12
)

local OpenWallMiniPanelButton = CreateButton(
    WallMiniButtonCard,
    "ABRIR MINI PAINEL",
    UDim2.new(0,18,0,68),
    UDim2.new(1,-36,0,30)
)

local WallMiniPanel = Instance.new("Frame")
WallMiniPanel.Name = "AUREUS_MovementMiniPanel"
WallMiniPanel.Size = UDim2.new(0, 255, 0, 170)
WallMiniPanel.AnchorPoint = Vector2.new(0.5, 0.5)
WallMiniPanel.Position = UDim2.new(0.5, 0, 0.58, 0)
WallMiniPanel.BackgroundColor3 = Color3.fromRGB(18, 20, 27)
WallMiniPanel.BorderSizePixel = 0
WallMiniPanel.Visible = false
WallMiniPanel.ZIndex = 30
WallMiniPanel.Parent = ScreenGui

local WallMiniCorner = Instance.new("UICorner")
WallMiniCorner.CornerRadius = UDim.new(0, 9)
WallMiniCorner.Parent = WallMiniPanel

local WallMiniStroke = Instance.new("UIStroke")
WallMiniStroke.Color = Colors.Red
WallMiniStroke.Thickness = 1
WallMiniStroke.Parent = WallMiniPanel

local WallMiniTop = Instance.new("Frame")
WallMiniTop.Size = UDim2.new(1, 0, 0, 42)
WallMiniTop.BackgroundColor3 = Color3.fromRGB(28, 30, 40)
WallMiniTop.BorderSizePixel = 0
WallMiniTop.ZIndex = 31
WallMiniTop.Parent = WallMiniPanel

local WallMiniTitle = Instance.new("TextLabel")
WallMiniTitle.BackgroundTransparency = 1
WallMiniTitle.Position = UDim2.new(0, 12, 0, 0)
WallMiniTitle.Size = UDim2.new(1, -58, 1, 0)
WallMiniTitle.Text = "AUREUS MOVIMENTO"
WallMiniTitle.TextColor3 = Colors.Text
WallMiniTitle.TextSize = 13
WallMiniTitle.Font = Enum.Font.GothamBold
WallMiniTitle.TextXAlignment = Enum.TextXAlignment.Left
WallMiniTitle.ZIndex = 32
WallMiniTitle.Parent = WallMiniTop

local WallMiniClose = Instance.new("TextButton")
WallMiniClose.Size = UDim2.new(0, 32, 0, 28)
WallMiniClose.Position = UDim2.new(1, -38, 0, 7)
WallMiniClose.BackgroundColor3 = Colors.Red
WallMiniClose.BorderSizePixel = 0
WallMiniClose.Text = "×"
WallMiniClose.TextColor3 = Colors.Text
WallMiniClose.TextSize = 20
WallMiniClose.Font = Enum.Font.GothamBold
WallMiniClose.ZIndex = 32
WallMiniClose.Parent = WallMiniTop

local WallCloseCorner = Instance.new("UICorner")
WallCloseCorner.CornerRadius = UDim.new(0, 6)
WallCloseCorner.Parent = WallMiniClose

local WallStatus = Instance.new("TextLabel")
WallStatus.BackgroundTransparency = 1
WallStatus.Position = UDim2.new(0, 14, 0, 55)
WallStatus.Size = UDim2.new(1, -28, 0, 34)
WallStatus.Text = "Modo central desligado."
WallStatus.TextColor3 = Colors.SubText
WallStatus.TextSize = 11
WallStatus.Font = Enum.Font.Gotham
WallStatus.TextWrapped = true
WallStatus.ZIndex = 31
WallStatus.Parent = WallMiniPanel

local WallToggle = Instance.new("TextButton")
WallToggle.Position = UDim2.new(0, 14, 1, -58)
WallToggle.Size = UDim2.new(1, -28, 0, 42)
WallToggle.BackgroundColor3 = Colors.Red
WallToggle.BorderSizePixel = 0
WallToggle.Text = "ATIVAR SUBIDA"
WallToggle.TextColor3 = Colors.Text
WallToggle.TextSize = 11
WallToggle.Font = Enum.Font.GothamBold
WallToggle.ZIndex = 31
WallToggle.Parent = WallMiniPanel

local WallToggleCorner = Instance.new("UICorner")
WallToggleCorner.CornerRadius = UDim.new(0, 7)
WallToggleCorner.Parent = WallToggle


local wallClimbConnection
local wallClimbSpeed = 38
local wallRayParams = RaycastParams.new()
wallRayParams.FilterType = Enum.RaycastFilterType.Exclude

local function stopWallClimb()
    if wallClimbConnection then
        wallClimbConnection:Disconnect()
        wallClimbConnection = nil
    end

    local character = Player.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    local root = character and character:FindFirstChild("HumanoidRootPart")

    if humanoid then
        humanoid.AutoRotate = true
    end

    if root then
        local velocity = root:FindFirstChild("AUREUS_WallClimbVelocity")
        if velocity then velocity:Destroy() end

        local attachment = root:FindFirstChild("AUREUS_WallClimbAttachment")
        if attachment then attachment:Destroy() end
    end
end

local function startWallClimb()
    stopWallClimb()

    wallClimbConnection = RunService.RenderStepped:Connect(function()
        if not wallModeEnabled then return end

        local character = Player.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        local root = character and character:FindFirstChild("HumanoidRootPart")

        if not humanoid or not root or humanoid.Health <= 0 then
            return
        end

        wallRayParams.FilterDescendantsInstances = {character}

        -- Detecta paredes à frente para manter o efeito de escalada.
        local look = root.CFrame.LookVector
        local right = root.CFrame.RightVector
        local origin = root.Position

        local hits = {
            workspace:Raycast(origin, look * 3.5, wallRayParams),
            workspace:Raycast(origin + right * 1.2, look * 3, wallRayParams),
            workspace:Raycast(origin - right * 1.2, look * 3, wallRayParams),
        }

        local hit
        for _, result in ipairs(hits) do
            if result
                and result.Instance
                and result.Instance.CanCollide
                and math.abs(result.Normal.Y) < 0.5 then
                hit = result
                break
            end
        end

        local velocity = root:FindFirstChild("AUREUS_WallClimbVelocity")

        if not velocity then
            local attachment = root:FindFirstChild("AUREUS_WallClimbAttachment")

            if not attachment then
                attachment = Instance.new("Attachment")
                attachment.Name = "AUREUS_WallClimbAttachment"
                attachment.Parent = root
            end

            velocity = Instance.new("LinearVelocity")
            velocity.Name = "AUREUS_WallClimbVelocity"
            velocity.Attachment0 = attachment
            velocity.RelativeTo = Enum.ActuatorRelativeTo.World
            velocity.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
            velocity.MaxForce = math.huge
            velocity.Parent = root
        end

        -- Enquanto o botão estiver ativo, sobe continuamente sem precisar
        -- ativar o sistema de voo separado.
        local x, z = 0, 0

        -- Se houver uma parede, mantém uma pequena pressão contra ela,
        -- fazendo o personagem subir como uma escalada.
        if hit then
            local push = -hit.Normal * 2
            x, z = push.X, push.Z
            WallStatus.Text = "Escalada ativa: subindo pela parede."
        else
            WallStatus.Text = "Movimento ativo: voando para cima."
        end

        velocity.VectorVelocity = Vector3.new(x, wallClimbSpeed, z)
        humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
        WallStatus.TextColor3 = Colors.Success
    end)
end
local wallModeEnabled = false

WallToggle.MouseButton1Click:Connect(function()
    wallModeEnabled = not wallModeEnabled

    if wallModeEnabled then
        UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
        WallToggle.Text = "DESLIGAR SUBIDA"
        WallStatus.Text = "Subida ativa. Você começa a voar para cima; ao encostar em uma parede, escala por ela."
        WallStatus.TextColor3 = Colors.Success
        startWallClimb()

        local ok, err = pcall(function()
            local remote = ReplicatedStorage:FindFirstChild("AUREUS_WallPhase")
            if remote and remote:IsA("RemoteEvent") then
                remote:FireServer(true)
            end
        end)
        if not ok then warn("[AUREUS Movement]", err) end
    else
        stopWallClimb()
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
        WallToggle.Text = "ATIVAR ESCALADA"
        WallStatus.Text = "Modo central desligado."
        WallStatus.TextColor3 = Colors.SubText

        local ok, err = pcall(function()
            local remote = ReplicatedStorage:FindFirstChild("AUREUS_WallPhase")
            if remote and remote:IsA("RemoteEvent") then
                remote:FireServer(false)
            end
        end)
        if not ok then warn("[AUREUS Movement]", err) end
    end
end)

-- Botão que entrega/remove o item "Teia".
-- Ao usar o item, tocar ou clicar em uma superfície cria uma teia visual até ela.
WallMiniPanel.Size = UDim2.new(0, 275, 0, 220)
WallToggle.Position = UDim2.new(0, 14, 1, -58)

local WebButton = Instance.new("TextButton")
WebButton.Position = UDim2.new(0, 14, 1, -108)
WebButton.Size = UDim2.new(1, -28, 0, 38)
WebButton.BackgroundColor3 = Color3.fromRGB(48, 50, 60)
WebButton.BorderSizePixel = 0
WebButton.Text = "DAR ITEM: TEIA"
WebButton.TextColor3 = Colors.Text
WebButton.TextSize = 11
WebButton.Font = Enum.Font.GothamBold
WebButton.ZIndex = 31
WebButton.Parent = WallMiniPanel

local webCorner = Instance.new("UICorner")
webCorner.CornerRadius = UDim.new(0, 7)
webCorner.Parent = WebButton

local webTool
local webFolder = workspace:FindFirstChild("AUREUS_Webs")
if not webFolder then
    webFolder = Instance.new("Folder")
    webFolder.Name = "AUREUS_Webs"
    webFolder.Parent = workspace
end

local function clearWebTool()
    if webTool then
        webTool:Destroy()
        webTool = nil
    end

    local backpack = Player:FindFirstChildOfClass("Backpack")
    if backpack then
        local old = backpack:FindFirstChild("Teia")
        if old then old:Destroy() end
    end

    local character = Player.Character
    if character then
        local old = character:FindFirstChild("Teia")
        if old then old:Destroy() end
    end

    WebButton.Text = "DAR ITEM: TEIA"
    WallStatus.Text = "Item de teia removido."
end

local function createWebPart(a, b, thickness)
    local distance = (b - a).Magnitude
    if distance < 0.05 then return end

    local part = Instance.new("Part")
    part.Name = "Teia"
    part.Anchored = true
    part.CanCollide = false
    part.CastShadow = false
    part.Material = Enum.Material.Neon
    part.Color = Color3.fromRGB(235, 235, 255)
    part.Transparency = 0.15
    part.Size = Vector3.new(thickness, thickness, distance)
    part.CFrame = CFrame.lookAt((a + b) / 2, b)
    part.Parent = webFolder

    task.delay(8, function()
        if part and part.Parent then
            part:Destroy()
        end
    end)
end

local function createWebAt(position, origin)
    -- Fio principal entre o jogador e o local tocado.
    createWebPart(origin, position, 0.08)

    -- Pequena teia radial no ponto selecionado.
    local radius = 3.5
    local points = {}

    for i = 1, 8 do
        local angle = math.rad((i - 1) * 45)
        local p = position + Vector3.new(
            math.cos(angle) * radius,
            math.sin(angle) * radius,
            0
        )
        points[i] = p
        createWebPart(position, p, 0.06)
    end

    for i = 1, 8 do
        createWebPart(points[i], points[(i % 8) + 1], 0.045)
    end
end

local function giveWebTool()
    if webTool and webTool.Parent then return end

    local backpack = Player:WaitForChild("Backpack")

    webTool = Instance.new("Tool")
    webTool.Name = "Teia"
    webTool.ToolTip = "Toque ou clique em uma superfície para lançar uma teia"
    webTool.RequiresHandle = false
    webTool.CanBeDropped = false
    webTool.Parent = backpack

    webTool.Activated:Connect(function()
        local character = Player.Character
        local root = character and character:FindFirstChild("HumanoidRootPart")
        local camera = workspace.CurrentCamera
        if not root or not camera then return end

        local mousePosition = UserInputService:GetMouseLocation()
        local ray = camera:ViewportPointToRay(mousePosition.X, mousePosition.Y)

        local params = RaycastParams.new()
        params.FilterType = Enum.RaycastFilterType.Exclude
        params.FilterDescendantsInstances = {character, webFolder}

        local hit = workspace:Raycast(ray.Origin, ray.Direction * 500, params)

        if hit then
            createWebAt(hit.Position, root.Position)
            WallStatus.Text = "Teia lançada!"
            WallStatus.TextColor3 = Colors.Success
        end
    end)

    WebButton.Text = "REMOVER ITEM: TEIA"
    WallStatus.Text = "Item Teia adicionado. Toque/clique em uma superfície para usar."
    WallStatus.TextColor3 = Colors.Success
end

WebButton.MouseButton1Click:Connect(function()
    if webTool and webTool.Parent then
        clearWebTool()
    else
        giveWebTool()
    end
end)

-- Item adicional: lança uma teia e puxa o jogador até o ponto selecionado.
local SwingButton = Instance.new("TextButton")
SwingButton.Position = UDim2.new(0, 14, 1, -158)
SwingButton.Size = UDim2.new(1, -28, 0, 38)
SwingButton.BackgroundColor3 = Color3.fromRGB(58, 45, 60)
SwingButton.BorderSizePixel = 0
SwingButton.Text = "DAR ITEM: TEIA DE BALANÇO"
SwingButton.TextColor3 = Colors.Text
SwingButton.TextSize = 10
SwingButton.Font = Enum.Font.GothamBold
SwingButton.ZIndex = 31
SwingButton.Parent = WallMiniPanel

local swingCorner = Instance.new("UICorner")
swingCorner.CornerRadius = UDim.new(0, 7)
swingCorner.Parent = SwingButton

WallMiniPanel.Size = UDim2.new(0, 275, 0, 270)
WallToggle.Position = UDim2.new(0, 14, 1, -58)
WebButton.Position = UDim2.new(0, 14, 1, -108)

local swingTool
local swingVelocity
local swingAttachment
local swingActive = false

local function stopSwing()
    swingActive = false
    if swingVelocity then swingVelocity:Destroy(); swingVelocity = nil end
    if swingAttachment then swingAttachment:Destroy(); swingAttachment = nil end
end

local function removeSwingTool()
    stopSwing()

    if swingTool then
        swingTool:Destroy()
        swingTool = nil
    end

    local backpack = Player:FindFirstChildOfClass("Backpack")
    if backpack then
        local old = backpack:FindFirstChild("Teia de Balanço")
        if old then old:Destroy() end
    end

    local character = Player.Character
    if character then
        local old = character:FindFirstChild("Teia de Balanço")
        if old then old:Destroy() end
    end

    SwingButton.Text = "DAR ITEM: TEIA DE BALANÇO"
end

local function pullToWeb(target)
    local character = Player.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    stopSwing()
    swingActive = true

    swingAttachment = Instance.new("Attachment")
    swingAttachment.Name = "AUREUS_SwingAttachment"
    swingAttachment.Parent = root

    swingVelocity = Instance.new("LinearVelocity")
    swingVelocity.Name = "AUREUS_SwingVelocity"
    swingVelocity.Attachment0 = swingAttachment
    swingVelocity.RelativeTo = Enum.ActuatorRelativeTo.World
    swingVelocity.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
    swingVelocity.MaxForce = math.huge
    swingVelocity.Parent = root

    createWebPart(root.Position, target, 0.1)

    task.spawn(function()
        while swingActive and swingVelocity and root and root.Parent do
            local offset = target - root.Position
            local distance = offset.Magnitude

            if distance < 4 then
                stopSwing()
                WallStatus.Text = "Você chegou até a teia."
                WallStatus.TextColor3 = Colors.Success
                break
            end

            local direction = offset.Unit
            local speed = math.clamp(distance * 2.2, 45, 110)
            swingVelocity.VectorVelocity = direction * speed
            RunService.Heartbeat:Wait()
        end
    end)
end

local function giveSwingTool()
    if swingTool and swingTool.Parent then return end

    swingTool = Instance.new("Tool")
    swingTool.Name = "Teia de Balanço"
    swingTool.ToolTip = "Clique em uma superfície para lançar a teia e ir até ela"
    swingTool.RequiresHandle = false
    swingTool.CanBeDropped = false
    swingTool.Parent = Player:WaitForChild("Backpack")

    swingTool.Activated:Connect(function()
        local character = Player.Character
        local camera = workspace.CurrentCamera
        if not character or not camera then return end

        local mousePosition = UserInputService:GetMouseLocation()
        local ray = camera:ViewportPointToRay(mousePosition.X, mousePosition.Y)

        local params = RaycastParams.new()
        params.FilterType = Enum.RaycastFilterType.Exclude
        params.FilterDescendantsInstances = {character, webFolder}

        local hit = workspace:Raycast(ray.Origin, ray.Direction * 700, params)

        if hit then
            pullToWeb(hit.Position)
            WallStatus.Text = "Teia lançada: indo até o ponto."
            WallStatus.TextColor3 = Colors.Success
        end
    end)

    SwingButton.Text = "REMOVER ITEM: TEIA DE BALANÇO"
    WallStatus.Text = "Item adicionado. Clique em uma superfície para lançar a teia."
    WallStatus.TextColor3 = Colors.Success
end

SwingButton.MouseButton1Click:Connect(function()
    if swingTool and swingTool.Parent then
        removeSwingTool()
    else
        giveSwingTool()
    end
end)


-- Arrastar o mini painel.
local wallDragging = false
local wallDragStart
local wallStartPosition
local wallDragInput

WallMiniTop.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        wallDragging = true
        wallDragStart = input.Position
        wallStartPosition = WallMiniPanel.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                wallDragging = false
            end
        end)
    end
end)

WallMiniTop.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
        wallDragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if wallDragging and input == wallDragInput then
        local delta = input.Position - wallDragStart
        WallMiniPanel.Position = UDim2.new(
            wallStartPosition.X.Scale,
            wallStartPosition.X.Offset + delta.X,
            wallStartPosition.Y.Scale,
            wallStartPosition.Y.Offset + delta.Y
        )
    end
end)

OpenWallMiniPanelButton.MouseButton1Click:Connect(function()
    WallMiniPanel.Visible = true
end)

WallMiniClose.MouseButton1Click:Connect(function()
    WallMiniPanel.Visible = false
end)


--// HOME / MAIN: ITEM DE TELEPORTE POR CLIQUE

local TeleportCard = CreateCard(HomePage, 150)
CreateLabel(TeleportCard, "TELEPORTE", UDim2.new(0,18,0,12), UDim2.new(1,-36,0,28), Colors.Red, 17)

local TeleportStatus = CreateLabel(
    TeleportCard,
    "Item desativado.",
    UDim2.new(0,18,0,46),
    UDim2.new(1,-36,0,22),
    Colors.SubText,
    12
)

local teleportTool

local function removeTeleportTool()
    if teleportTool then
        teleportTool:Destroy()
        teleportTool = nil
    end
    local backpack = Player:FindFirstChildOfClass("Backpack")
    if backpack then
        local old = backpack:FindFirstChild("AUREUS Teleport")
        if old then old:Destroy() end
    end
    local character = Player.Character
    if character then
        local old = character:FindFirstChild("AUREUS Teleport")
        if old then old:Destroy() end
    end
end

local function createTeleportTool()
    removeTeleportTool()

    local tool = Instance.new("Tool")
    tool.Name = "AUREUS Teleport"
    tool.ToolTip = "Clique em um local para se teleportar"
    tool.RequiresHandle = false
    tool.CanBeDropped = false
    tool.Parent = Player:WaitForChild("Backpack")

    teleportTool = tool

    local mouse
    tool.Equipped:Connect(function(currentMouse)
        mouse = currentMouse
    end)

    tool.Activated:Connect(function()
        local success, err = pcall(function()
            local character = Player.Character
            local root = character and character:FindFirstChild("HumanoidRootPart")
            if not root then return end

            local targetCFrame
            if mouse and mouse.Hit then
                targetCFrame = mouse.Hit
            end

            if targetCFrame then
                root.CFrame = CFrame.new(targetCFrame.Position + Vector3.new(0, 3, 0))
            end
        end)

        if not success then
            warn("[AUREUS Teleport]", err)
        end
    end)
end

local TeleportToggle = CreateButton(
    TeleportCard,
    "DAR ITEM DE TELEPORTE",
    UDim2.new(0,18,0,84),
    UDim2.new(1,-36,0,42)
)

TeleportToggle.MouseButton1Click:Connect(function()
    if teleportTool then
        removeTeleportTool()
        TeleportToggle.Text = "DAR ITEM DE TELEPORTE"
        TeleportStatus.Text = "Item removido do inventário."
        TeleportStatus.TextColor3 = Colors.SubText
    else
        createTeleportTool()
        TeleportToggle.Text = "REMOVER ITEM DE TELEPORTE"
        TeleportStatus.Text = "Item adicionado. Equipe e clique em um local."
        TeleportStatus.TextColor3 = Colors.Success
    end
end)


-- LOCAL PLAYER: voo e assistente local
local FlyCard = CreateCard(LocalPlayerPage, 250)
CreateLabel(FlyCard, "VOO", UDim2.new(0,18,0,12), UDim2.new(1,-36,0,28), Colors.Red, 17)
local FlyStatus = CreateLabel(FlyCard, "Voo desligado.", UDim2.new(0,18,0,44), UDim2.new(1,-36,0,22), Colors.SubText, 12)
local flying, moveUp, moveDown, flySpeed, flyConnection = false, false, false, 50, nil
local function getRoot()
    local character = Player.Character
    return character and character:FindFirstChild("HumanoidRootPart") or nil
end
-- Controles de voo ficam fora do painel, na tela, próximos à área dos controles móveis.
local FlyControls = Instance.new("Frame")
FlyControls.Name = "AUREUS_FlyControls"
FlyControls.AnchorPoint = Vector2.new(1, 1)
FlyControls.Position = UDim2.new(1, -18, 1, -115)
FlyControls.Size = UDim2.new(0, 104, 0, 104)
FlyControls.BackgroundTransparency = 1
FlyControls.Visible = false
FlyControls.Parent = ScreenGui

local UpButton = Instance.new("TextButton")
UpButton.Name = "AUREUS_FlyUp"
UpButton.Size = UDim2.new(0, 48, 0, 48)
UpButton.Position = UDim2.new(0, 0, 0, 0)
UpButton.BackgroundColor3 = Colors.Topbar
UpButton.Text = "↑"
UpButton.TextColor3 = Colors.Text
UpButton.Font = Enum.Font.GothamBold
UpButton.TextSize = 24
UpButton.AutoButtonColor = false
UpButton.Parent = FlyControls
local UpCorner = Instance.new("UICorner"); UpCorner.CornerRadius = UDim.new(1, 0); UpCorner.Parent = UpButton
local UpStroke = Instance.new("UIStroke"); UpStroke.Color = Colors.Red; UpStroke.Thickness = 1.5; UpStroke.Parent = UpButton

local DownButton = Instance.new("TextButton")
DownButton.Name = "AUREUS_FlyDown"
DownButton.Size = UDim2.new(0, 48, 0, 48)
DownButton.Position = UDim2.new(0, 0, 1, -48)
DownButton.BackgroundColor3 = Colors.Topbar
DownButton.Text = "↓"
DownButton.TextColor3 = Colors.Text
DownButton.Font = Enum.Font.GothamBold
DownButton.TextSize = 24
DownButton.AutoButtonColor = false
DownButton.Parent = FlyControls
local DownCorner = Instance.new("UICorner"); DownCorner.CornerRadius = UDim.new(1, 0); DownCorner.Parent = DownButton
local DownStroke = Instance.new("UIStroke"); DownStroke.Color = Colors.Red; DownStroke.Thickness = 1.5; DownStroke.Parent = DownButton
local function startFly()
    if flying then return end
    flying = true
    flyConnection = RunService.RenderStepped:Connect(function()
        local root = getRoot()
        if not flying or not root then return end
        local y = (moveUp and flySpeed or 0) + (moveDown and -flySpeed or 0)
        root.AssemblyLinearVelocity = Vector3.new(root.AssemblyLinearVelocity.X, y, root.AssemblyLinearVelocity.Z)
    end)
end
local function stopFly()
    flying, moveUp, moveDown = false, false, false
    if flyConnection then flyConnection:Disconnect(); flyConnection = nil end
end
local function bindHold(button, setter)
    button.MouseButton1Down:Connect(function() if flying then setter(true) end end)
    button.MouseButton1Up:Connect(function() setter(false) end)
    button.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.Touch and flying then setter(true) end end)
    button.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.Touch then setter(false) end end)
end
bindHold(UpButton, function(v) moveUp = v end)
bindHold(DownButton, function(v) moveDown = v end)
local FlyToggle = CreateButton(FlyCard, "ATIVAR VOO", UDim2.new(0,18,0,142), UDim2.new(1,-36,0,42))
FlyToggle.MouseButton1Click:Connect(function()
    if flying then
        stopFly(); FlyControls.Visible=false
        FlyToggle.Text="ATIVAR VOO"; FlyStatus.Text="Voo desligado."
    else
        startFly(); FlyControls.Visible=true
        FlyToggle.Text="DESLIGAR VOO"; FlyStatus.Text="Voo ativado. Use as setas na tela."; FlyStatus.TextColor3=Colors.Success
    end
end)


--// AUREUS AI: botão que abre uma janela de conversa arrastável
local AssistantOpenCard = CreateCard(LocalPlayerPage, 110)
CreateLabel(AssistantOpenCard, "AUREUS AI", UDim2.new(0,18,0,12), UDim2.new(1,-36,0,28), Colors.Red, 17)
CreateLabel(
    AssistantOpenCard,
    "Abra o chat para perguntar sobre as funções do AUREUS.",
    UDim2.new(0,18,0,42),
    UDim2.new(1,-36,0,22),
    Colors.SubText,
    12
)

local OpenAssistantButton = CreateButton(
    AssistantOpenCard,
    "ABRIR AUREUS AI",
    UDim2.new(0,18,0,68),
    UDim2.new(1,-36,0,32)
)

-- Histórico salvo enquanto o painel/script estiver ativo.
local ChatHistory = {}

local AIWindow = Instance.new("Frame")
AIWindow.Name = "AUREUS_AI_Window"
AIWindow.Size = UDim2.new(0, 340, 0, 430)
AIWindow.AnchorPoint = Vector2.new(0.5, 0.5)
AIWindow.Position = UDim2.new(0.5, 0, 0.5, 0)
AIWindow.BackgroundColor3 = Color3.fromRGB(18, 20, 27)
AIWindow.BorderSizePixel = 0
AIWindow.Visible = false
AIWindow.ZIndex = 20
AIWindow.Parent = ScreenGui

local AIWindowCorner = Instance.new("UICorner")
AIWindowCorner.CornerRadius = UDim.new(0, 10)
AIWindowCorner.Parent = AIWindow

local AIWindowStroke = Instance.new("UIStroke")
AIWindowStroke.Color = Colors.Red
AIWindowStroke.Thickness = 1
AIWindowStroke.Parent = AIWindow

local AITopbar = Instance.new("Frame")
AITopbar.Name = "Topbar"
AITopbar.Size = UDim2.new(1, 0, 0, 48)
AITopbar.BackgroundColor3 = Color3.fromRGB(28, 30, 40)
AITopbar.BorderSizePixel = 0
AITopbar.ZIndex = 21
AITopbar.Parent = AIWindow

local AITitle = Instance.new("TextLabel")
AITitle.BackgroundTransparency = 1
AITitle.Position = UDim2.new(0, 16, 0, 0)
AITitle.Size = UDim2.new(1, -70, 1, 0)
AITitle.Text = "✦ AUREUS AI"
AITitle.TextColor3 = Colors.Text
AITitle.TextSize = 16
AITitle.Font = Enum.Font.GothamBold
AITitle.TextXAlignment = Enum.TextXAlignment.Left
AITitle.ZIndex = 22
AITitle.Parent = AITopbar

local AICloseButton = Instance.new("TextButton")
AICloseButton.Size = UDim2.new(0, 36, 0, 32)
AICloseButton.Position = UDim2.new(1, -42, 0, 8)
AICloseButton.BackgroundColor3 = Colors.Red
AICloseButton.Text = "×"
AICloseButton.TextColor3 = Colors.Text
AICloseButton.TextSize = 22
AICloseButton.Font = Enum.Font.GothamBold
AICloseButton.BorderSizePixel = 0
AICloseButton.ZIndex = 22
AICloseButton.Parent = AITopbar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = AICloseButton

local Messages = Instance.new("ScrollingFrame")
Messages.Name = "Messages"
Messages.Position = UDim2.new(0, 10, 0, 58)
Messages.Size = UDim2.new(1, -20, 1, -122)
Messages.BackgroundTransparency = 1
Messages.BorderSizePixel = 0
Messages.ScrollBarThickness = 5
Messages.CanvasSize = UDim2.new()
Messages.AutomaticCanvasSize = Enum.AutomaticSize.Y
Messages.ZIndex = 21
Messages.Parent = AIWindow

local MessagesLayout = Instance.new("UIListLayout")
MessagesLayout.Padding = UDim.new(0, 8)
MessagesLayout.SortOrder = Enum.SortOrder.LayoutOrder
MessagesLayout.Parent = Messages

local InputBox = Instance.new("TextBox")
InputBox.Position = UDim2.new(0, 10, 1, -54)
InputBox.Size = UDim2.new(1, -100, 0, 42)
InputBox.BackgroundColor3 = Color3.fromRGB(28, 30, 40)
InputBox.BorderSizePixel = 0
InputBox.PlaceholderText = "Digite sua mensagem..."
InputBox.PlaceholderColor3 = Colors.SubText
InputBox.Text = ""
InputBox.TextColor3 = Colors.Text
InputBox.TextSize = 13
InputBox.Font = Enum.Font.Gotham
InputBox.ClearTextOnFocus = false
InputBox.ZIndex = 22
InputBox.Parent = AIWindow

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 7)
InputCorner.Parent = InputBox

local SendButton = Instance.new("TextButton")
SendButton.Position = UDim2.new(1, -82, 1, -54)
SendButton.Size = UDim2.new(0, 72, 0, 42)
SendButton.BackgroundColor3 = Colors.Red
SendButton.BorderSizePixel = 0
SendButton.Text = "ENVIAR"
SendButton.TextColor3 = Colors.Text
SendButton.TextSize = 11
SendButton.Font = Enum.Font.GothamBold
SendButton.ZIndex = 22
SendButton.Parent = AIWindow

local SendCorner = Instance.new("UICorner")
SendCorner.CornerRadius = UDim.new(0, 7)
SendCorner.Parent = SendButton

local function addMessage(author, message, isUser)
    local container = Instance.new("Frame")
    container.BackgroundColor3 = isUser and Color3.fromRGB(45, 31, 35) or Color3.fromRGB(28, 30, 40)
    container.BorderSizePixel = 0
    container.Size = UDim2.new(1, 0, 0, 0)
    container.AutomaticSize = Enum.AutomaticSize.Y
    container.ZIndex = 22
    container.Parent = Messages

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 7)
    corner.Parent = container

    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 10, 0, 7)
    label.Size = UDim2.new(1, -20, 0, 0)
    label.AutomaticSize = Enum.AutomaticSize.Y
    label.Text = author .. ":\n" .. message
    label.TextColor3 = Colors.Text
    label.TextSize = 13
    label.Font = Enum.Font.Gotham
    label.TextWrapped = true
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Top
    label.ZIndex = 23
    label.Parent = container

    local padding = Instance.new("UIPadding")
    padding.PaddingBottom = UDim.new(0, 8)
    padding.Parent = container

    table.insert(ChatHistory, {
        author = author,
        message = message,
        isUser = isUser,
    })

    task.defer(function()
        Messages.CanvasPosition = Vector2.new(0, math.max(0, Messages.AbsoluteCanvasSize.Y))
    end)
end

local function answerQuestion(question)
    local q = string.lower(question or "")

    if q:find("voo") or q:find("voar") then
        return "O voo é ativado pelo botão ATIVAR VOO. Quando ativo, os controles SUBIR e DESCER aparecem na tela."
    elseif q:find("teleport") or q:find("teleporte") then
        return "Na Home existe um botão que adiciona o item AUREUS Teleport ao inventário. Com o item equipado, você clica em um local para se mover até ele."
    elseif q:find("executor") or q:find("loadstring") then
        return "A aba Executor reúne as ferramentas configuradas para execução dentro do projeto."
    elseif q:find("martelo") or q:find("gear") then
        return "A aba Martelo reúne funções como reentrar no servidor e outras ações locais."
    elseif q:find("amigo") then
        return "A aba Amigos permite selecionar jogadores pelo nome e enviar a solicitação para a lógica autorizada pelo servidor."
    elseif q:find("script") or q:find("painel") or q:find("aureus") then
        return "AUREUS v2.3.9 organiza as funções em abas como Home, Local Player, Executor, Scripts, Gear, Amigos e Players."
    else
        return "Posso explicar as funções disponíveis no AUREUS. Pergunte sobre voo, teleporte, abas, executor, Gear ou Amigos."
    end
end

local function sendMessage()
    local message = string.gsub(InputBox.Text or "", "^%s*(.-)%s*$", "%1")
    if message == "" then return end

    addMessage(Player.Name, message, true)
    InputBox.Text = ""

    task.wait(0.15)
    addMessage("AUREUS AI", answerQuestion(message), false)
end

SendButton.MouseButton1Click:Connect(sendMessage)

InputBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        sendMessage()
    end
end)

-- Arrastar a janela pela barra superior.
local dragging = false
local dragStart
local startPosition
local dragInput

AITopbar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPosition = AIWindow.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

AITopbar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        AIWindow.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

OpenAssistantButton.MouseButton1Click:Connect(function()
    AIWindow.Visible = true

    if #ChatHistory == 0 then
        addMessage("AUREUS AI", "Olá, " .. Player.Name .. "! Pergunte o que quiser sobre as funções do AUREUS.", false)
    end
end)

AICloseButton.MouseButton1Click:Connect(function()
    AIWindow.Visible = false
end)


local HammerCard = CreateCard(GearPage, 210)
CreateLabel(HammerCard, "MARTELO", UDim2.new(0,18,0,12), UDim2.new(1,-36,0,28), Colors.Red, 17)

local HammerStatus = CreateLabel(HammerCard, "Escolha uma ação.", UDim2.new(0,18,0,44), UDim2.new(1,-36,0,22), Colors.SubText, 12)

local RejoinButton = CreateButton(HammerCard, "REENTRAR NO SERVIDOR", UDim2.new(0,18,0,76), UDim2.new(1,-36,0,42))

RejoinButton.MouseButton1Click:Connect(function()
	HammerStatus.Text = "Reentrando..."
	HammerStatus.TextColor3 = Colors.SubText

	local Success, ErrorMessage = pcall(function()
		if game.JobId and game.JobId ~= "" then
			TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, Player)
		else
			TeleportService:Teleport(game.PlaceId, Player)
		end
	end)

	if not Success then
		HammerStatus.Text = "Erro ao reentrar."
		HammerStatus.TextColor3 = Colors.Error
		warn("[AUREUS Rejoin]", ErrorMessage)
	end
end)

local InstantDeathButton = CreateButton(HammerCard, "MORRER INSTANTANEAMENTE", UDim2.new(0,18,0,132), UDim2.new(1,-36,0,42))

InstantDeathButton.MouseButton1Click:Connect(function()
	local Success, ErrorMessage = pcall(function()
		local Character = Player.Character or Player.CharacterAdded:Wait()
		local Humanoid = Character:FindFirstChildOfClass("Humanoid")
		if not Humanoid then error("Humanoid não encontrado.") end
		Humanoid.Health = 0
	end)

	if Success then
		HammerStatus.Text = "Ação executada."
		HammerStatus.TextColor3 = Colors.Success
	else
		HammerStatus.Text = "Erro ao executar."
		HammerStatus.TextColor3 = Colors.Error
		warn("[AUREUS Hammer]", ErrorMessage)
	end
end)


local PlayersCard = CreateCard(PlayersPage, 130)
CreateLabel(PlayersCard, "PLAYERS", UDim2.new(0,18,0,15), UDim2.new(1,-36,0,30), Colors.Red, 17)
CreateLabel(PlayersCard, "Jogador atual: " .. Player.Name, UDim2.new(0,18,0,55), UDim2.new(1,-36,0,25), Colors.Text, 13)
CreateLabel(PlayersCard, "Mais opções podem ser adicionadas nesta página.", UDim2.new(0,18,0,85), UDim2.new(1,-36,0,25), Colors.SubText, 12)

local function OpenPage(Name)
	local NewPage = Pages[Name]
	if not NewPage or NewPage == CurrentPage then return end

	ContentHeader.Text = string.upper(Name)

	if CurrentPage then
		Tween(CurrentPage, {Position = UDim2.new(-0.05,0,0,0)}, 0.12)
		task.wait(0.12)
		CurrentPage.Visible = false
	end

	NewPage.Visible = true
	NewPage.CanvasPosition = Vector2.new(0,0)
	NewPage.Position = UDim2.new(0.05,0,0,0)
	Tween(NewPage, {Position = UDim2.new(0,0,0,0)}, 0.18)
	CurrentPage = NewPage

	for ButtonName, Data in pairs(MenuButtons) do
		local Active = ButtonName == Name
		Tween(Data.Button, {BackgroundColor3 = Active and Colors.CardHover or Colors.Sidebar})
		Data.Indicator.Visible = Active
		Data.Icon.TextColor3 = Active and Colors.Red or Colors.SubText
		Data.Label.TextColor3 = Active and Colors.Text or Color3.fromRGB(180,180,185)
	end
end

local function CreateMenuButton(Name, IconText, Order)
	local Button = Instance.new("TextButton")
	Button.LayoutOrder = Order
	Button.Size = UDim2.new(1,-4,0,52)
	Button.BackgroundColor3 = Colors.Sidebar
	Button.BorderSizePixel = 0
	Button.Text = ""
	Button.AutoButtonColor = false
	Button.Parent = MenuScroll

	local Indicator = Instance.new("Frame")
	Indicator.Size = UDim2.new(0,3,1,0)
	Indicator.BackgroundColor3 = Colors.Red
	Indicator.BorderSizePixel = 0
	Indicator.Visible = false
	Indicator.Parent = Button

	local Icon = Instance.new("TextLabel")
	Icon.Position = UDim2.new(0,17,0,0)
	Icon.Size = UDim2.new(0,35,1,0)
	Icon.BackgroundTransparency = 1
	Icon.Text = IconText
	Icon.TextColor3 = Colors.SubText
	Icon.Font = Enum.Font.GothamBold
	Icon.TextSize = 20
	Icon.Parent = Button

	local Label = Instance.new("TextLabel")
	Label.Position = UDim2.new(0,62,0,0)
	Label.Size = UDim2.new(1,-70,1,0)
	Label.BackgroundTransparency = 1
	Label.Text = Name
	Label.TextColor3 = Color3.fromRGB(180,180,185)
	Label.TextXAlignment = Enum.TextXAlignment.Left
	Label.Font = Enum.Font.GothamBold
	Label.TextSize = 14
	Label.Parent = Button

	MenuButtons[Name] = {Button=Button, Indicator=Indicator, Icon=Icon, Label=Label}

	Button.MouseEnter:Connect(function()
		if CurrentPage ~= Pages[Name] then Tween(Button, {BackgroundColor3 = Colors.CardHover}) end
	end)
	Button.MouseLeave:Connect(function()
		if CurrentPage ~= Pages[Name] then Tween(Button, {BackgroundColor3 = Colors.Sidebar}) end
	end)
	Button.MouseButton1Click:Connect(function()
		OpenPage(Name)
	end)
end

CreateMenuButton("Home", "⌂", 1)
CreateMenuButton("Local Player", "♙", 2)
CreateMenuButton("Executor", "‹›", 3)
CreateMenuButton("Scripts", ">_", 4)
CreateMenuButton("Gear", "⚒", 5)
CreateMenuButton("Players", "♜", 6)

local Footer = Instance.new("TextLabel")
Footer.AnchorPoint = Vector2.new(0.5,1)
Footer.Position = UDim2.new(0.5,0,1,-6)
Footer.Size = UDim2.new(1,-10,0,18)
Footer.BackgroundTransparency = 1
Footer.Text = "AUREUS • " .. VERSION
Footer.TextColor3 = Colors.SubText
Footer.Font = Enum.Font.Gotham
Footer.TextSize = 10
Footer.Parent = Content

--// =========================================================
--// MINIMIZAR PARA BOTÃO CIRCULAR AUREUS
--// =========================================================

local IsMinimized = false

local FloatingButton = Instance.new("TextButton")
FloatingButton.Name = "AUREUS_FloatingButton"
FloatingButton.AnchorPoint = Vector2.new(0.5, 0.5)
FloatingButton.Position = UDim2.fromScale(0.5, 0.5)
FloatingButton.Size = UDim2.new(0, 48, 0, 48)
FloatingButton.BackgroundColor3 = Colors.Topbar
FloatingButton.BorderSizePixel = 0
FloatingButton.Text = ""
FloatingButton.Visible = false
FloatingButton.AutoButtonColor = false
FloatingButton.Parent = ScreenGui

local FloatingCorner = Instance.new("UICorner")
FloatingCorner.CornerRadius = UDim.new(1, 0)
FloatingCorner.Parent = FloatingButton

local FloatingStroke = Instance.new("UIStroke")
FloatingStroke.Color = Colors.Red
FloatingStroke.Thickness = 1.5
FloatingStroke.Parent = FloatingButton

-- Mesmo estilo do título do painel: AUREUS em vermelho
local FloatingIcon = Instance.new("TextLabel")
FloatingIcon.Size = UDim2.new(1, 0, 0, 25)
FloatingIcon.Position = UDim2.new(0, 0, 0, 4)
FloatingIcon.BackgroundTransparency = 1
FloatingIcon.RichText = true
FloatingIcon.Text = '<font color="rgb(220,55,65)">A</font>'
FloatingIcon.Font = Enum.Font.GothamBold
FloatingIcon.TextSize = 24
FloatingIcon.Parent = FloatingButton

local FloatingText = Instance.new("TextLabel")
FloatingText.Size = UDim2.new(1, 0, 0, 13)
FloatingText.Position = UDim2.new(0, 0, 0, 28)
FloatingText.BackgroundTransparency = 1
FloatingText.Text = "AUREUS"
FloatingText.TextColor3 = Colors.Text
FloatingText.Font = Enum.Font.GothamBold
FloatingText.TextSize = 7
FloatingText.Parent = FloatingButton

MinimizeButton.MouseButton1Click:Connect(function()
	if IsMinimized then return end

	IsMinimized = true
	FloatingButton.Position = Main.Position
	Main.Visible = false
	FloatingButton.Visible = true
	Tween(FloatingButton, {Size = UDim2.new(0, 52, 0, 52)}, 0.12)
end)

--// =========================================================
--// BOTÃO CIRCULAR: ARRASTAR NÃO ABRE, CLIQUE ABRE
--// =========================================================

local FloatingDragging = false
local FloatingDragInput
local FloatingDragStart
local FloatingStartPosition
local FloatingMoved = false
local CLICK_THRESHOLD = 8

FloatingButton.InputBegan:Connect(function(Input)
	if Input.UserInputType == Enum.UserInputType.MouseButton1
		or Input.UserInputType == Enum.UserInputType.Touch then
		FloatingDragging = true
		FloatingDragInput = Input
		FloatingDragStart = Input.Position
		FloatingStartPosition = FloatingButton.Position
		FloatingMoved = false
	end
end)

--// =========================================================
--// ARRASTAR PAINEL PRINCIPAL
--// =========================================================

local Dragging = false
local DragInput
local DragStart
local StartPosition

Topbar.InputBegan:Connect(function(Input)
	if Input.UserInputType == Enum.UserInputType.MouseButton1
		or Input.UserInputType == Enum.UserInputType.Touch then
		Dragging = true
		DragInput = Input
		DragStart = Input.Position
		StartPosition = Main.Position
	end
end)

--// =========================================================
--// REDIMENSIONAR PELOS DOIS CANTOS INFERIORES
--// =========================================================

local function CreateResizeHandle(Name, Anchor, Position)
	local Handle = Instance.new("Frame")
	Handle.Name = Name
	Handle.AnchorPoint = Anchor
	Handle.Position = Position
	Handle.Size = UDim2.new(0, 22, 0, 22)
	Handle.BackgroundTransparency = 1
	Handle.Active = true
	Handle.ZIndex = 50
	Handle.Parent = Main
	return Handle
end

local ResizeLeft = CreateResizeHandle(
	"ResizeBottomLeft",
	Vector2.new(0, 1),
	UDim2.new(0, 0, 1, 0)
)

local ResizeRight = CreateResizeHandle(
	"ResizeBottomRight",
	Vector2.new(1, 1),
	UDim2.new(1, 0, 1, 0)
)

local Resizing = false
local ResizeInput
local ResizeSide
local ResizeStartMouse
local ResizeStartSize
local ResizeStartPosition

local MIN_WIDTH = 360
local MIN_HEIGHT = 260
local MAX_WIDTH = 620
local MAX_HEIGHT = 400

local function BeginResize(Side, Input)
	if IsMinimized then return end

	if Input.UserInputType == Enum.UserInputType.MouseButton1
		or Input.UserInputType == Enum.UserInputType.Touch then
		Resizing = true
		ResizeInput = Input
		ResizeSide = Side
		ResizeStartMouse = Input.Position
		ResizeStartSize = Main.AbsoluteSize
		ResizeStartPosition = Main.Position
	end
end

ResizeLeft.InputBegan:Connect(function(Input)
	BeginResize("Left", Input)
end)

ResizeRight.InputBegan:Connect(function(Input)
	BeginResize("Right", Input)
end)

--// =========================================================
--// MOVIMENTO GLOBAL
--// =========================================================

UserInputService.InputChanged:Connect(function(Input)
	-- Move o painel
	if Dragging and Input == DragInput then
		local Delta = Input.Position - DragStart
		Main.Position = UDim2.new(
			StartPosition.X.Scale,
			StartPosition.X.Offset + Delta.X,
			StartPosition.Y.Scale,
			StartPosition.Y.Offset + Delta.Y
		)
	end

	-- Move o botão minimizado
	if FloatingDragging and Input == FloatingDragInput then
		local Delta = Input.Position - FloatingDragStart

		if Delta.Magnitude >= CLICK_THRESHOLD then
			FloatingMoved = true
		end

		FloatingButton.Position = UDim2.new(
			FloatingStartPosition.X.Scale,
			FloatingStartPosition.X.Offset + Delta.X,
			FloatingStartPosition.Y.Scale,
			FloatingStartPosition.Y.Offset + Delta.Y
		)
	end

	-- Redimensiona pelo canto inferior esquerdo/direito
	if Resizing and Input == ResizeInput then
		local Delta = Input.Position - ResizeStartMouse

		local NewWidth
		local NewHeight = math.clamp(
			ResizeStartSize.Y + Delta.Y,
			MIN_HEIGHT,
			MAX_HEIGHT
		)

		if ResizeSide == "Right" then
			NewWidth = math.clamp(
				ResizeStartSize.X + Delta.X,
				MIN_WIDTH,
				MAX_WIDTH
			)
		else
			NewWidth = math.clamp(
				ResizeStartSize.X - Delta.X,
				MIN_WIDTH,
				MAX_WIDTH
			)
		end

		local WidthChange = NewWidth - ResizeStartSize.X
		local HeightChange = NewHeight - ResizeStartSize.Y

		local NewPosX = ResizeStartPosition.X.Offset
		local NewPosY = ResizeStartPosition.Y.Offset + HeightChange / 2

		if ResizeSide == "Right" then
			NewPosX = NewPosX + WidthChange / 2
		else
			NewPosX = NewPosX - WidthChange / 2
		end

		Main.Size = UDim2.new(0, NewWidth, 0, NewHeight)
		Main.Position = UDim2.new(
			ResizeStartPosition.X.Scale,
			NewPosX,
			ResizeStartPosition.Y.Scale,
			NewPosY
		)
	end
end)

--// =========================================================
--// SOLTAR INPUT
--// =========================================================

UserInputService.InputEnded:Connect(function(Input)
	if Dragging and Input == DragInput then
		Dragging = false
		DragInput = nil
	end

	if Resizing and Input == ResizeInput then
		Resizing = false
		ResizeInput = nil
		ResizeSide = nil
	end

	if FloatingDragging and Input == FloatingDragInput then
		FloatingDragging = false
		FloatingDragInput = nil

		-- Apenas um clique sem arrastar restaura o painel.
		if not FloatingMoved then
			Main.Position = UDim2.fromScale(0.5, 0.5)
			Main.Visible = true
			FloatingButton.Visible = false
			FloatingButton.Size = UDim2.new(0, 48, 0, 48)
			IsMinimized = false
		end
	end
end)

CloseButton.MouseButton1Click:Connect(function()
	Tween(Main, {Size = UDim2.new(0, 0, 0, 0)}, 0.2)
	task.wait(0.2)
	ScreenGui:Destroy()
end)

OpenPage("Home")

local StartSize = Main.Size
Main.Size = UDim2.new(0, 40, 0, 40)
Tween(Main, {Size = StartSize}, 0.28)
