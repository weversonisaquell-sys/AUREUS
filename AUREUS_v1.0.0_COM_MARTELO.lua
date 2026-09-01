--// AUREUS v1.0.0
--// Painel vermelho compacto, arrastável, com scroll e botão ORG minimizado

local Players = game:GetService("Players")
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


local FriendsCard = CreateCard(HomePage, 110)
CreateLabel(FriendsCard, "AMIGOS", UDim2.new(0,18,0,12), UDim2.new(1,-36,0,25), Colors.Red, 16)
local FriendsStatus = CreateLabel(FriendsCard, "Pronto.", UDim2.new(0,18,0,42), UDim2.new(1,-36,0,20), Colors.SubText, 12)
local KillFriendsButton = CreateButton(FriendsCard, "ELIMINAR AMIGOS", UDim2.new(0,18,0,68), UDim2.new(1,-36,0,32))

KillFriendsButton.MouseButton1Click:Connect(function()
	local Success, Result = pcall(function()
		local Remote = ReplicatedStorage:FindFirstChild("AUREUS_KillFriend")
		if not Remote or not Remote:IsA("RemoteEvent") then
			error("RemoteEvent AUREUS_KillFriend não encontrado.")
		end

		local Sent = 0
		for _, Target in ipairs(Players:GetPlayers()) do
			if Target ~= Player then
				local FriendSuccess, FriendResult = pcall(function()
					return Player:IsFriendsWith(Target.UserId)
				end)

				if FriendSuccess and FriendResult then
					Remote:FireServer(Target.UserId)
					Sent += 1
				end
			end
		end
		return Sent
	end)

	if Success then
		FriendsStatus.Text = "Solicitação enviada para " .. tostring(Result) .. " amigo(s)."
		FriendsStatus.TextColor3 = Colors.Success
	else
		FriendsStatus.Text = "Erro: " .. tostring(Result)
		FriendsStatus.TextColor3 = Colors.Error
		warn("[AUREUS Friends]", Result)
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
