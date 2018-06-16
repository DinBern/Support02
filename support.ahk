Run, QuickAnswer.ahk, , Max UseErrorLevel
Run, Music.ahk, , Max UseErrorLevel
;######################################################################################################
buildscr = 10 ;версия для сравнения, если меньше чем в sptest.ini - обновляем
downlurl := "https://github.com/DinBern/Support02/blob/master/updt.exe?raw=true"
downllen := "https://raw.githubusercontent.com/DinBern/Support02/master/sptest.ini"


WM_HELP(){
    IniRead, vupd, %a_temp%/sptest.ini, UPD, v
    IniRead, desupd, %a_temp%/sptest.ini, UPD, des
    desupd := Utf8ToAnsi(desupd)
    IniRead, updupd, %a_temp%/sptest.ini, UPD, upd
    updupd := Utf8ToAnsi(updupd)
    msgbox, , Список изменений версии %vupd%, %updupd%
    return
}

OnMessage(0x53, "WM_HELP")
Gui +OwnDialogs

SplashTextOn, , 60,Автообновление, Запуск скрипта. Ожидайте..`nПроверяем наличие обновлений.
URLDownloadToFile, %downllen%, %a_temp%/sptest.ini
IniRead, buildupd, %a_temp%/sptest.ini, UPD, build
if buildupd =
{
    SplashTextOn, , 60,Автообновление, Запуск скрипта. Ожидайте..`nОшибка. Нет связи с сервером.
}
if buildupd > % buildscr
{
    IniRead, vupd, %a_temp%/sptest.ini, UPD, v
    SplashTextOn, , 60,Автообновление, Запуск скрипта. Ожидайте..`nОбнаружено обновление до версии %vupd%!
    IniRead, desupd, %a_temp%/sptest.ini, UPD, des
    desupd := Utf8ToAnsi(desupd)
    IniRead, updupd, %a_temp%/sptest.ini, UPD, upd
    updupd := Utf8ToAnsi(updupd)
    SplashTextoff
    msgbox, 16384, Обновление скрипта до версии %vupd%, %desupd%
    IfMsgBox OK
    {
        msgbox, 1, Обновление скрипта до версии %vupd%, Хотите ли Вы обновиться?
        IfMsgBox OK
        {
            put2 := % A_ScriptFullPath
            RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\SAMP ,put2 , % put2
            SplashTextOn, , 60,Автообновление, Обновление. Ожидайте..`nОбновляем скрипт до версии %vupd%!
            URLDownloadToFile, %downlurl%, %a_temp%/updt.exe
            run, %a_temp%/updt.exe
            exitapp
        }
    }
}
SplashTextoff
;#####################################################
Menu,Tray,NoStandard 
Menu,Tray,DeleteAll
Menu,Tray,Add,Остаток секунд,time
Menu,Tray,Add,Перезагрузить скрипт,relog
Menu,Tray,Add,Выключить скрипт,off

afk:
WinWait, GTA:SA:MP
Start := A_TickCount
title:=800
StringTrimRight, times, times, 7
WinWaitActive, GTA:SA:MP, , %title%
if errorlevel
{
Process, wait,gta_sa.exe, 5.5
NewPID = %ErrorLevel%
if NewPID = 0
{
    goto, afk
}
SoundPlay, *64
MsgBox, 4, Support Team 02, СКОРО КИКНЕТ ЗА АФК, РАЗВЕРНУТЬ ИГРУ?
IfMsgBox Yes
	{
		WinActivate, GTA:SA:MP 
		sendinput,{esc}
		
		goto, afk
	} else {
		goto, afk
	}
}
goto, afk
return

time:
Process, wait,gta_sa.exe, 0.1
NewPID = %ErrorLevel%
if NewPID = 0
{
	TrayTip, AFK, % "GTA:SA:MP НЕ ЗАПУЩЕН"
    goto, afk
}
title:=800
times := title - (A_TickCount  - Start)/1000
StringTrimRight, times, times, 7
TrayTip, AFK, % Start ? "ОСТАЛОСЬ " . times . " СЕКУНД" : "GTA:SA:MP НЕ ЗАПУЩЕН", , 16
return
relog:
Reload
return
off: 
ExitApp
return
;######################################################################################################
;###################################     Замены слов       ############################################
;######################################################################################################
::/dolg::
SendMessage, 0x50,, 0x4190419,, A
sendinput,[/setdebt - поставить крышу][/getdebt - выбить долг][/debtors - список должников]
return
::/off::
::/offfilter::
SendMessage, 0x50,, 0x4190419,, A
sendinput,/offmfilter name(по нику)/minRank(>N)/maxRank(<N)/sort/clear(очистить фильтр).
return
::/offsort::
SendMessage, 0x50,, 0x4190419,, A
sendinput,/offmfilter sort [0-нет|1-ранг|2-дата входа|3-принятие] [по 0-возраст.|1-убыв.].
return
::/gk::
SendMessage, 0x50,, 0x4190419,, A
sendinput,/givecopkeys - ПД/Армия | /givekeys - Мэрия | /givenewskeys - пропуск в новостях.
return
::/zak::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Каждый час игры прибавляет по 1 пункту к законопослушности.
return
::/120hp::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Имея зависимость меньше 2000 - Максимальное ХП достигает 120.
return
::/130hp::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Имея зависимость 2000-3000 - Максимальное ХП достигает 130.
return
::/140hp::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Имея зависимость 3000-4000 - Максимальное ХП достигает 140.
return
::/150hp::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Имея зависимость 4000-5000 - Максимальное ХП достигает 150.
return
::/160hp::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Имея зависимость от 5000 - Максимальное ХП достигает 160.
return
::/spc::
SendMessage, 0x50,, 0x4190419,, A
sendinput, /spawnchange - Изменение места вашего респауна.
return
::/zpb::
SendMessage, 0x50,, 0x4190419,, A
sendinput, ЗП = [50 вирт]*[количество захваченных территорий] | /gmap для просмотра территорий.
return
::/dina::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Вы можете спавнить рабочие машины на стоянке,если вам не хватило автомобиля вашего скила.
return
::/vipvirt::
SendMessage, 0x50,, 0x4190419,, A
sendinput,| [Bronze VIP]: 1 млн вирт | [Silver VIP]: 10 млн вирт | [Gold VIP]: 25 млн вирт. |
return
::/viprub::
SendMessage, 0x50,, 0x4190419,, A
sendinput,| [Bronze VIP]: 250 рублей | [Silver VIP]: 2500 рублей | [Gold VIP]: ~ 6000 рублей. |
return
::/cinv::
SendMessage, 0x50,, 0x4190419,, A
sendinput,/cinvite [слот] [id или -1] - принять/уволить крупье || /setmng - назначить менеджера.
return
::/banda::
SendMessage, 0x50,, 0x4190419,, A
sendinput,/robhouse | /usedrugs | /get guns | /sellgun | /materials get\put\sell | /unloading
return
::/meh::
SendMessage, 0x50,, 0x4190419,, A
sendinput,/repair - чинить авто | /refill - заправить авто | /fillgarage - заправить гараж.
return
::/zern::
SendMessage, 0x50,, 0x4190419,, A
sendinput,/cornmenu - Закупка/продажа урожая/зерна.
return
::/taxi::
SendMessage, 0x50,, 0x4190419,, A
sendinput,[Sentinel:15 skill| 700 вирт] [Sultan: 30 skill| 1500 вирт] [Buffalo: 40 skill| 5000 вирт].
return
::/rk::
SendMessage, 0x50,, 0x4190419,, A
sendinput,/repairkit | Нужно находиться у капота | Повышает только до 50 engine.
return
::/zpu::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Зарплата: [A| 4000-7750] [B| 1750-3244] [C| 700-1371] [D| 400-547] [N| 250-324].
return
::/da::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Лимит времени на продажу 72 часа / На аукционе 24 часа / Гос.аукцион 12 часов.
return
::/zd::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Данный дом выставлен на аукцион торговой площадки (/gps 0 22).
return
::/kr::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Заплатите долг /repaydebt и вступите в любую фракцию.
return
::/jfinv::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Свяжитесь с лидером профсоюза /dir > Лидеры профсоюза и попросите принять вас.
return
::/sp::
SendMessage, 0x50,, 0x4190419,, A
sendinput, /spawnchange
return
::/lvlup::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Играть на сервере. За каждый час игры 1 exp. Ваш лвл посмотреть можно тут: /stats
return
::/tc::
SendMessage, 0x50,, 0x4190419,, A
sendinput, /thefcancel
return
::/ts::
SendMessage, 0x50,, 0x4190419,, A
sendinput, /timestamp -  отображение времени компьютера перед каждым сообщением в окне чата.
return
::/muz::
SendMessage, 0x50,, 0x4190419,, A
sendinput, В настройках ГТА.  Esc > Настройки > Настройки звука > Радио
return
::/prl::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Промо-код: {#}SRP
return
::/promol::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Промо-коды: {#}etozhemad {#}HappyTown {#}hovan {#}mobster {#}koron
return
::/promol1::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Промо-коды: {#}chumakov {#}spyro {#}diller {#}brabus {#}tags {#}tarko
return
::/promol2::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Промо-коды: {#}poznjaki {#}MALFOY {#}mathews {#}spyro {#}war {#}tags
return
::/trans::
SendMessage, 0x50,, 0x4190419,, A
sendinput, /transferaccount || С 02 сервера переносов нет.
return
::/expert::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Группа наиболее активных пользователей раздела предложений по улучшению проекта.
return
::/bon::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Информация по бонусам: /boostinfo
return
::/sugon::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Скилл автоугонщика: Nope[0] || D[50] || C[100] || B[250] || A[500]
return
::/ougon::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Опыт автоугонщика за 1 авто: Nope 2 || D 4 || C 5 || B 6 || A 8
return
::/avtoverh::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Возить людей на авто можно на: Sadler / Yosemite / Bobcat / Walton.
return
::/glist::
SendMessage, 0x50,, 0x4190419,, A
sendinput,За 1 патрон: Sdpistol [1]; Deagle [3]; Shotgun [3]; SMG [2]; AK-47 [3]; M4A1 [3]; Rifle [5]
return
::/1lvl::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Работы на 1 лвл: Ферма (/gps 5) || Грузчики (/gps 1 7).
return
::/2lvl::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Работы на 2 лвл: Автобусник (/gps 1 4) || Таксист || Хотдогер (/gps 1 5).
return
::/3lvl::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Работы на 3 лвл: Раз.продуктов(/gps 1 2)| Зерновоз | Механик | Инкассатор(/gps 1 6)
return
::/4lvl::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Фракции на 4 лвл: Банды / Байкеры / Медики / Армия.
return
::/5lvl::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Фракции на 5 лвл: Банды / Байкеры / Медики / Армия / Новости / Автошкола / Мэрия.
return
::/6lvl::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Фракции на 6 лвл: Банды / Байкеры / Медики / Армия / Новости / ПД с армии / АШ / Мэрия.
return
::/7lvl::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Фракции на 7 лвл: Банды / Байкеры / Медики / Армия / Новости / ПД с армии / АШ / Мэрия.
return
::/8lvl::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Фракции на 8 лвл: Банды / Байкеры / Медики / Армия / Новости / ПД с армии / АШ / Мэрия.
return
::/9lvl::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Фракции на 9 лвл: Банды / Байкеры / Медики / Армия / Новости / ПД с армии / АШ / Мэрия.
return
::/10lvl::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Фракции на 10 лвл: Банды / Байкеры / Медики / Армия / Новости / ПД / АШ / Мафия / Мэрия.
return
::/11lvl::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Фракции на 11 лвл: Банды / Байкеры / Медики / Армия / Новости / ПД / АШ / Мафия / Мэрия.
return
::/12lvl::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Фракции на 12 лвл: Доступны все фракции сервера.
return
::/davto::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Sadler / Cadrona / Walton / Previon / Perennial - 100.000 вирт.
return
::/benz::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Бензин: [S] 800 литров || [A] 500 литров || [B] 300 литров || [C] 200 литров
return
::/gl::
SendMessage, 0x50,, 0x4190419,, A
Random, rand, 1, 13
if rand = 1
sendinput, Хорошего дня и приятной игры на нашем сервере)
if rand = 2
sendinput, Приятной игры на 02 сервере :)
if rand = 3
sendinput, Приятного времяпровождения на сервере и хорошего настроения :-)
if rand = 4
sendinput, Удачной игры на 02 сервере :)
if rand = 5
sendinput, Весёлой и увлекательной игры на 02 сервере)
if rand = 6
sendinput, Удачного дня и увлекательной игры на 02 сервере :)
if rand = 7
sendinput, Желаем Вам приятной игры на нашем сервере!
if rand = 8
sendinput, Пусть удачным будет день! Приятной игры на 02 :)
if rand = 9
sendinput, Хорошего дня, добрых новостей и радостных событий ;)
if rand = 10
sendinput, Хорошего и продуктивного дня)
if rand = 11
sendinput, Желаю чудесного дня и хорошего настроения на 02 сервере)
if rand = 12
sendinput, Support`s Team желает Вам приятной игры на SRP 02.
if rand = 13
sendinput, Пускай этот день будет для вас удачным и наполнен только положительными эмоциями :)
return
::/zona::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Автовокзал ЛС, СФ, ЛВ|Грузчики|Мэрия|Наркопритон(внутр.)|Больницы|АШ|Гонки|Дерби|Пейнт
return
::/zona1::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Казино|Магазины/Аммо|склады,порты|КПЗ|Фермы|Автоугон|места большого скопления людей
return
::/kv1c::
SendMessage, 0x50,, 0x4190419,, A
sendinput, В 1 час: [A] 50 вирт | [B] 100 вирт | [C] 150 вирт | [D] 100 вирт | [N] 50 вирт
return
::/kv1m::
SendMessage, 0x50,, 0x4190419,, A
sendinput, В 1 месяц: [A] 33600 | [B] 67200 | [C] 100800 вирт | [D] 67200 | [N] 33600 вирт
return
::/kv1n::
SendMessage, 0x50,, 0x4190419,, A
sendinput, В 1 неделю: [A] 8400 | [B] 16800 | [C] 25200 вирт | [D] 16800 | [N] 8400 вирт
return
::/kv2n::
SendMessage, 0x50,, 0x4190419,, A
sendinput, В 2 недели: [A] 16800 | [B] 33600 | [C] 50400 вирт | [D] 33600 | [N] 16800 вирт
return
::/int::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Интерьер: [S/A: 500 000] [B: 400 000] [C: 300 000] [D: 200 000] [N: 100 000] [Кв: 200 000]
return
::/rep::
SendMessage, 0x50,, 0x4190419,, A
sendinput, С данным вопросом следует обратиться сюда: /aquestion
return
::/geth::
SendMessage, 0x50,, 0x4190419,, A
sendinput,/gethousemoney - вернуть деньги за слетевший в гос. дом.
return
::/riba::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Продавать у закусночных командой /fish sellfish (5 вирт за 1 кг).
return
::/grib::
::/gribi::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Продавать у закусночных командой /sellgrib (5 вирт за 1 шт).
return
::/dom::
SendMessage, 0x50,, 0x4190419,, A
sendinput,/changehouse - предложить обмен/продать дом игроку || /sellhouse - слить в гос.
return
::/car::
SendMessage, 0x50,, 0x4190419,, A
sendinput,/changecar - предложить обмен авто игроку || /sellcar - продать авто в гос.
return
::/rang::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Увеличивает ЗП, доступна рация (/f), скидка на аренду.
return
::/rangup::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Ранг повышается автоматически если вы состоите в профсоюзе, и выполняете зад. рабочего.
return
::/skill::
::/skil::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Повышает лимит на зарплату, скидка на аренду.
return
::/skillup::
::/skilup::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Скилл повышается автоматически при выполнении задания рабочего.
return
::/vert::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Завод КАСС (Б-23) | Посёлок Tierra-Robada (В-4) | Небоскрёб в ЛС (У-19)
return
::/chat::
SendMessage, 0x50,, 0x4190419,, A
sendinput,/pagesize [10..20] - регулировка кол-во строк | /fontsize [-3..5] - размер шрифта.
return
::/rinok::
SendMessage, 0x50,, 0x4190419,, A
sendinput,По рыночным ценам не консультируем. Следите за объявлениями.
return
::/promo::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Промо-код нужно вводить при регистрации в поле пригласившего игрока.
return
::/offtop::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Cообщение, выходящее за рамки установленной темы общения.
return
::/priziv::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Следите за гос.новостями (cиний чатик будет).
return
::/rpdm::
SendMessage, 0x50,, 0x4190419,, A
sendinput,ДМ - Убийство без причины.
return
::/rpdb::
SendMessage, 0x50,, 0x4190419,, A
sendinput,ДБ - Убийство с машины (машиной).
return
::/rpsk::
SendMessage, 0x50,, 0x4190419,, A
sendinput,СК - Убийство на месте возрождения.
return
::/rptk::
SendMessage, 0x50,, 0x4190419,, A
sendinput,ТК - Убийство члена своей фракции
return
::/rprp::
SendMessage, 0x50,, 0x4190419,, A
sendinput,РП - Игра по ролям, где каждый должен соблюдать свою роль.
return
::/rpmg::
SendMessage, 0x50,, 0x4190419,, A
sendinput,МГ - Использование информации из реального мира в игровой чат.
return
::/rppg::
SendMessage, 0x50,, 0x4190419,, A
sendinput,ПГ - Изображение из себя героя.
return
::/rprk::
SendMessage, 0x50,, 0x4190419,, A
sendinput,РК - Возвращение на место, где Вас убили.
return
::/tr::
::/dal::
::/dalnoboi::
::/dalnoboj::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Команды дальнобоя: /truck | /truck load | /truck mon | /truck unload | /truck trailer
return
::/news::
::/novosti::
SendMessage, 0x50,, 0x4190419,, A
sendinput,CФн -11555 (/radio 1) || ЛСн -11888 (/radio 2) || ЛВн -11333 (/radio 3)
return
::/gonki::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Гонки: 1:05 | 4:05 | 6:05 | 9:05 | 12:05 | 15:05 | 18:05 | 21:05
return
::/paint::
::/peint::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Пейнтболл: 3:05 | 8:05 | 11:05 | 14:05 | 17:05 | 20:05 | 23:05
return
::/derbi::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Дерби: 2:05 | 7:05 | 10:05 | 13:05 | 16:05 | 19:05 | 22:05
return
::/sto::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Команды на СТО: /tupdate | /tpanel | /addtq | /tinfo | /f  /endtune
return
::/ferma::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Команды на ферме: /funload | /fpanel | /ffixcar | /finfo | /f
return
::/str::
SendMessage, 0x50,, 0x4190419,, A
sendinput,/strobe - Доступно сотрудникам Мэрии,Полиции,ФБР и VIP игрокам (с SILVER).
return
::/biker::
SendMessage, 0x50,, 0x4190419,, A
sendinput,/bunload | /empty | /fill | /members| /warehouse | /f | /getgun | /bbalance
return
::/prava::
SendMessage, 0x50,, 0x4190419,, A
sendinput,[1-2 лвл - 500] [3-5 лвл - 5000] [6-15 лвл - 10 000] [16 и выше лвл - 30 000]
return
::/z::
SendMessage, 0x50,, 0x4190419,, A
sendinput,На АЗС заправить- /fill || Канистрой- /fillcar || Купить канистру- /get fuel.
return
::/lic::
::/lica::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Рыбалка: 2к / Вода: 5к / Воздух: 10к / Оружие: 50к вирт(3лвл) / Бизнес: 100к
return
::/krupa::
::/kazino::
::/casino::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Команды для казино: /f | /cinvite | /cinfo | Кнопка F
return
::/g::
::/google::
::/gogle::
SendMessage, 0x50,, 0x4190419,, A
sendinput,/mm >> [2] Настройки >> [1] Защита >> [2] Настройки Google Authenticator
return
::/g1::
::/google1::
::/gogle1::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Заходите в [0] Сгенерировать ключ > В поле вводи пароль аккаунта > секр. код
return
::/g2::
::/google2::
::/gogle2::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Вводите в приложение на телефоне код в Google Authenticator и получите 6 цифр.
return
::/g3::
::/google3::
::/gogle3::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Введите их в игре и вы успешно установили защиту.
return
::/premii::
SendMessage, 0x50,, 0x4190419,, A
sendinput,10 = 5.000 / 20 = 15.000 / 30 = 50.000 / 40 = 500.000 / 50 = 5.000.000
return
::/don::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Не знаем, также как и вы. Следите за новостями форума: Список форумов > Новости
return
::/adm::
SendMessage, 0x50,, 0x4190419,, A
sendinput,/admins или /aquestion- напишите им сами. Мы не предоставляем эту информацию.
return
::/jb::
::/zb::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Список форумов > Игровые обсуждения > Жалобы на админов\саппортов.
return
;######################################################################################################
;###################################          SAMP         ############################################
;######################################################################################################

global ADDR_SET_POSITION                    := 0xB7CD98
global ADDR_SET_POSITION_OFFSET             := 0x14
global ADDR_SET_POSITION_X_OFFSET           := 0x30
global ADDR_SET_POSITION_Y_OFFSET           := 0x34
global ADDR_SET_POSITION_Z_OFFSET           := 0x38
global ADDR_SET_INTERIOR_OFFSET             := 0xB72914
global SAMP_SZIP_OFFSET                     := 0x20
;~ global SAMP_SZHOSTNAME_OFFSET               := 0x121
global SAMP_INFO_SETTINGS_OFFSET            := 0x3C5
global SAMP_DIALOG_LINENUMBER_OFFSET        := 0x140

; ErrorLevels
global ERROR_OK                             := 0
global ERROR_PROCESS_NOT_FOUND              := 1
global ERROR_OPEN_PROCESS                   := 2
global ERROR_INVALID_HANDLE                 := 3
global ERROR_MODULE_NOT_FOUND               := 4
global ERROR_ENUM_PROCESS_MODULES           := 5
global ERROR_ZONE_NOT_FOUND                 := 6
global ERROR_CITY_NOT_FOUND                 := 7
global ERROR_READ_MEMORY                    := 8
global ERROR_WRITE_MEMORY                   := 9
global ERROR_ALLOC_MEMORY                   := 10
global ERROR_FREE_MEMORY                    := 11
global ERROR_WAIT_FOR_OBJECT                := 12
global ERROR_CREATE_THREAD                  := 13
            
; GTA Addresses         
global ADDR_ZONECODE                        := 0xA49AD4      ;Player Zone
global ADDR_POSITION_X                      := 0xB6F2E4      ;Player X Position
global ADDR_POSITION_Y                      := 0xB6F2E8      ;Player Y Position
global ADDR_POSITION_Z                      := 0xB6F2EC      ;Player Z Position
global ADDR_CPED_PTR                        := 0xB6F5F0      ;Player CPED Pointer
global ADDR_CPED_HPOFF                      := 0x540         ;Player Health
global ADDR_CPED_ARMOROFF                   := 0x548         ;Player Armour
global ADDR_CPED_MONEY                      := 0x0B7CE54     ;Player Money
global ADDR_CPED_INTID                      := 0xA4ACE8      ;Player Interior-ID
global ADDR_CPED_SKINIDOFF                  := 0x22          ;Player Skin-ID
;           
global ADDR_VEHICLE_PTR                     := 0xBA18FC      ;Vehicle CPED Pointer
global ADDR_VEHICLE_HPOFF                   := 0x4C0         ;Vehicle Health
global ADDR_VEHICLE_DOORSTATE               := 0x4F8         ;Vehicle Door Status
global ADDR_VEHICLE_ENGINESTATE             := 0x428         ;Vehicle Engine Status
global ADDR_VEHICLE_SIRENSTATE              := 0x1069 
global ADDR_VEHICLE_SIRENSTATE2             := 0x1300 
global ADDR_VEHICLE_LIGHTSTATE              := 0x584         ;Vehicle Light Status
global ADDR_VEHICLE_MODEL                   := 0x22          ;Vehicle Car-ID & Car-Name
global ADDR_VEHICLE_TYPE                    := 0x590         ;Vehicle Typ-ID (1 = Car)
global ADDR_VEHICLE_DRIVER                  := 0x460         ;Vehicle Driver
global ADDR_VEHICLE_X                       := 0x44          ;Vehicle Speed X
global ADDR_VEHICLE_Y                       := 0x48          ;Vehicle Speed Y
global ADDR_VEHICLE_Z                       := 0x4C          ;Vehicle Speed Z
global oAirplaneModels := [417, 425, 447, 460, 469, 476, 487, 488, 497, 511, 512, 513, 519, 520, 548, 553, 563, 577, 592, 593]
global oBikeModels := [481,509,510]
global ovehicleNames := ["Landstalker","Bravura","Buffalo","Linerunner","Perrenial","Sentinel","Dumper","Firetruck","Trashmaster","Stretch","Manana","Infernus","Voodoo","Pony","Mule","Cheetah","Ambulance","Leviathan","Moonbeam","Esperanto","Taxi","Washington","Bobcat","Whoopee","BFInjection","Hunter","Premier","Enforcer","Securicar","Banshee","Predator","Bus","Rhino","Barracks","Hotknife","Trailer","Previon","Coach","Cabbie","Stallion","Rumpo","RCBandit","Romero","Packer","Monster","Admiral","Squalo","Seasparrow","Pizzaboy","Tram","Trailer","Turismo","Speeder","Reefer","Tropic","Flatbed","Yankee","Caddy","Solair","Berkley'sRCVan","Skimmer","PCJ-600","Faggio","Freeway","RCBaron","RCRaider","Glendale","Oceanic","Sanchez","Sparrow","Patriot","Quad","Coastguard","Dinghy","Hermes","Sabre","Rustler","ZR-350","Walton","Regina","Comet","BMX","Burrito","Camper","Marquis","Baggage","Dozer","Maverick","NewsChopper","Rancher","FBIRancher","Virgo","Greenwood","Jetmax","Hotring","Sandking","BlistaCompact","PoliceMaverick","Boxvillde","Benson","Mesa","RCGoblin","HotringRacerA","HotringRacerB","BloodringBanger","Rancher","SuperGT","Elegant","Journey","Bike","MountainBike","Beagle","Cropduster","Stunt","Tanker","Roadtrain","Nebula","Majestic","Buccaneer","Shamal","hydra","FCR-900","NRG-500","HPV1000","CementTruck","TowTruck","Fortune","Cadrona","FBITruck","Willard","Forklift","Tractor","Combine","Feltzer","Remington","Slamvan","Blade","Freight","Streak","Vortex","Vincent","Bullet","Clover","Sadler","Firetruck","Hustler","Intruder","Primo","Cargobob","Tampa","Sunrise","Merit","Utility","Nevada","Yosemite","Windsor","Monster","Monster","Uranus","Jester","Sultan","Stratum","Elegy","Raindance","RCTiger","Flash","Tahoma","Savanna","Bandito","FreightFlat","StreakCarriage","Kart","Mower","Dune","Sweeper","Broadway","Tornado","AT-400","DFT-30","Huntley","Stafford","BF-400","NewsVan","Tug","Trailer","Emperor","Wayfarer","Euros","Hotdog","Club","FreightBox","Trailer","Andromada","Dodo","RCCam","Launch","PoliceCar","PoliceCar","PoliceCar","PoliceRanger","Picador","S.W.A.T","Alpha","Phoenix","GlendaleShit","SadlerShit","Luggage","Luggage","Stairs","Boxville","Tiller","UtilityTrailer"]
global oweaponNames := ["Fist","Brass Knuckles","Golf Club","Nightstick","Knife","Baseball Bat","Shovel","Pool Cue","Katana","Chainsaw","Purple Dildo","Dildo","Vibrator","Silver Vibrator","Flowers","Cane","Grenade","Tear Gas","Molotov Cocktail", "", "", "", "9mm","Silenced 9mm","21Desert Eagle","Shotgun","Sawnoff Shotgun","Combat Shotgun","Micro SMG/Uzi","MP5","AK-47","M4","Tec-9","Country Rifle","Sniper Rifle","RPG","HS Rocket","Flamethrower","Minigun","Satchel Charge","Detonator","Spraycan","Fire Extinguisher","Camera","Night Vis Goggles","Thermal Goggles","Parachute"]
global oradiostationNames := ["Playback FM", "K Rose", "K-DST", "Bounce FM", "SF-UR", "Radio Los Santos", "Radio X", "CSR 103.9", "K-JAH West", "Master Sounds 98.3", "WCTR Talk Radio", "User Track Player", "Radio Off"]
global oweatherNames := ["EXTRASUNNY_LA", "SUNNY_LA", "EXTRASUNNY_SMOG_LA", "SUNNY_SMOG_LA", "CLOUDY_LA", "SUNNY_SF", "EXTRASUNNY_SF", "CLOUDY_SF", "RAINY_SF", "FOGGY_SF", "SUNNY_VEGAS", "EXTRASUNNY_VEGAS", "CLOUDY_VEGAS", "EXTRASUNNY_COUNTRYSIDE", "SUNNY_COUNTRYSIDE", "CLOUDY_COUNTRYSIDE", "RAINY_COUNTRYSIDE", "EXTRASUNNY_DESERT", "SUNNY_DESERT", "SANDSTORM_DESERT", "UNDERWATER", "EXTRACOLOURS_1", "EXTRACOLOURS_2"]

; SAMP Адреса
global ADDR_SAMP_INCHAT_PTR                 := 0x21a10c
global ADDR_SAMP_INCHAT_PTR_OFF             := 0x55
global ADDR_SAMP_USERNAME                   := 0x219A6F
global FUNC_SAMP_SENDCMD                    := 0x65c60
global FUNC_SAMP_SENDSAY                    := 0x57f0
global FUNC_SAMP_ADDTOCHATWND               := 0x64520
global ADDR_SAMP_CHATMSG_PTR                := 0x21a0e4
global FUNC_SAMP_SHOWGAMETEXT               := 0x9c2c0
global FUNC_SAMP_PLAYAUDIOSTR               := 0x62da0
global FUNC_SAMP_STOPAUDIOSTR               := 0x629a0
; ########################## Стили Диалога ##########################
global DIALOG_STYLE_MSGBOX			        := 0
global DIALOG_STYLE_INPUT 			        := 1
global DIALOG_STYLE_LIST			        := 2
global DIALOG_STYLE_PASSWORD		        := 3
global DIALOG_STYLE_TABLIST			        := 4
global DIALOG_STYLE_TABLIST_HEADERS	        := 5
; ######################### Структуры диалога #########################
global SAMP_DIALOG_STRUCT_PTR				:= 0x21A0B8
global SAMP_DIALOG_PTR1_OFFSET				:= 0x1C
global SAMP_DIALOG_LINES_OFFSET 			:= 0x44C
global SAMP_DIALOG_INDEX_OFFSET				:= 0x443
global SAMP_DIALOG_BUTTON_HOVERING_OFFSET	:= 0x465
global SAMP_DIALOG_BUTTON_CLICKED_OFFSET	:= 0x466
global SAMP_DIALOG_PTR2_OFFSET 				:= 0x20
global SAMP_DIALOG_LINECOUNT_OFFSET			:= 0x150
global SAMP_DIALOG_OPEN_OFFSET				:= 0x28
global SAMP_DIALOG_STYLE_OFFSET				:= 0x2C
global SAMP_DIALOG_ID_OFFSET				:= 0x30
global SAMP_DIALOG_TEXT_PTR_OFFSET			:= 0x34
global SAMP_DIALOG_CAPTION_OFFSET			:= 0x40
global FUNC_SAMP_SHOWDIALOG				 	:= 0x6B9C0
global FUNC_SAMP_CLOSEDIALOG				:= 0x6C040
global FUNC_UPDATESCOREBOARD                := 0x8A10
global SAMP_INFO_OFFSET                     := 0x21A0F8
global ADDR_SAMP_CRASHREPORT 				:= 0x5CF2C
global SAMP_PPOOLS_OFFSET                   := 0x3CD
global SAMP_PPOOL_PLAYER_OFFSET             := 0x18
global SAMP_SLOCALPLAYERID_OFFSET           := 0x4
global SAMP_ISTRLEN_LOCALPLAYERNAME_OFFSET  := 0x1A
global SAMP_SZLOCALPLAYERNAME_OFFSET        := 0xA
global SAMP_PSZLOCALPLAYERNAME_OFFSET       := 0xA
global SAMP_PREMOTEPLAYER_OFFSET            := 0x2E
global SAMP_ISTRLENNAME___OFFSET            := 0x1C
global SAMP_SZPLAYERNAME_OFFSET             := 0xC
global SAMP_PSZPLAYERNAME_OFFSET            := 0xC
global SAMP_ILOCALPLAYERPING_OFFSET         := 0x26
global SAMP_ILOCALPLAYERSCORE_OFFSET        := 0x2A
global SAMP_IPING_OFFSET                    := 0x28
global SAMP_ISCORE_OFFSET                   := 0x24
global SAMP_ISNPC_OFFSET                    := 0x4
global SAMP_PLAYER_MAX                      := 1004
global SAMP_KILLSTAT_OFFSET                 := 0x21A0EC
global multVehicleSpeed_tick                := 0
global CheckpointCheck 						:= 0xC7DEEA
global rmaddrs 								:= [0xC7DEC8, 0xC7DECC, 0xC7DED0]

; Sizes
global SIZE_SAMP_CHATMSG                    := 0xFC
; Internal
global hGTA                                 := 0x0
global dwGTAPID                             := 0x0
global dwSAMP                               := 0x0
global pMemory                              := 0x0
global pParam1                              := 0x0
global pParam2                              := 0x0
global pParam3                              := 0x0
global pParam4                              := 0x0
global pParam5                              := 0x0
global pInjectFunc                          := 0x0
global nZone                                := 1
global nCity                                := 1
global bInitZaC                             := 0
global iRefreshScoreboard                   := 0
global oScoreboardData                      := ""
global iRefreshHandles                      := 0
global iUpdateTick                          := 1500 ; Время в мс, используемое в функциях getPlayerNameById и др. для обновления данных. По умолчанию 2500 (2.5 сек)

getWeaponAmmo(ByRef Ammo := "", ByRef Clip := "", slot := -1)
{
    if(!checkHandles())
        return -1
    if(!CPed := readDWORD(hGTA, ADDR_CPED_PTR))
        return -1
    if slot not between 0 and 12
    {
        VarSetCapacity(slot, 1)
        DllCall("ReadProcessMemory", "UInt", hGTA, "UInt", CPed + 0x718, "Str", slot, "UInt", 1, "UInt*", 0)
        slot := NumGet(slot, 0, "short")
        if slot >= 12544
            slot -= 12544
    }
    struct := CPed + 0x5AC
    VarSetCapacity(Ammo, 4)
    VarSetCapacity(Clip, 4)
    DllCall("ReadProcessMemory", "UInt", hGTA, "UInt", struct + (0x1C * slot), "Str", Ammo, "UInt", 4, "UInt*", 0)
    DllCall("ReadProcessMemory", "UInt", hGTA, "UInt", struct + (0x1C * slot) - 0x4, "Str", Clip, "UInt", 4, "UInt*", 0)
    Ammo := NumGet(Ammo, 0, "int")
    Clip := NumGet(Clip, 0, "int")
    return Ammo
}

IsLineOfSightClear(startX,startY,startZ,endX,endY,endZ,bCheckBuildings, bCheckVehicles, bCheckPeds, bCheckObjects, bCheckDummies, bSeeThroughStuff, bIgnoreSomeObjectsForCamera) {
    if(!checkHandles())
        return 0
    dwFunc := 0x56A490  
    dwLen := 59
    VarSetCapacity(injectData, dwLen, 0)
    ; buffer fur die 2 Positionen erstellen
    ; 3*float = 12 *2  
    VarSetCapacity(vectors, 24, 0)
    NumPut(startX, vectors, 0, "Float")
    NumPut(startY, vectors, 4, "Float")
    NumPut(startZ, vectors, 8, "Float")
    NumPut(endX, vectors, 12, "Float")
    NumPut(endY, vectors, 16, "Float")
    NumPut(endZ, vectors, 20, "Float")
    ; Vectoren in den reservierten Bereich schreiben, damit darauf zugegriffen werden kann
    writeRaw(hGTA, pParam1, &vectors, 24)
    ; push
    NumPut(0x68, injectData, 0, "UChar")
    NumPut(bIgnoreSomeObjectsForCamera, injectData, 1, "UInt")
    NumPut(0x68, injectData, 5, "UChar")
    NumPut(bSeeThroughStuff, injectData, 6, "UInt")
    NumPut(0x68, injectData, 10, "UChar")
    NumPut(bCheckDummies, injectData, 11, "UInt")
    NumPut(0x68, injectData, 15, "UChar")
    NumPut(bCheckObjects, injectData, 16, "UInt")
    NumPut(0x68, injectData, 20, "UChar")
    NumPut(bCheckPeds, injectData, 21, "UInt")
    NumPut(0x68, injectData, 25, "UChar")
    NumPut(bCheckVehicles, injectData, 26, "UInt")
    NumPut(0x68, injectData, 30, "UChar")
    NumPut(bCheckBuildings, injectData, 31, "UInt")
    NumPut(0x68, injectData, 35, "UChar")
    NumPut(pParam1+12, injectData, 36, "UInt")
    NumPut(0x68, injectData, 40, "UChar")
    NumPut(pParam1, injectData, 41, "UInt")
    ; call
    NumPut(0xE8, injectData, 45, "UChar")
    offset := dwFunc - (pInjectFunc + 50)
    NumPut(offset, injectData, 46, "UInt")
    ; Ruckgabewert
    NumPut(0xA2, injectData, 50, "UChar")
    NumPut(pParam2, injectData, 51, "UInt")
    ; add esp 0x24
    NumPut(0xC483, injectData, 55, "UShort")
    NumPut(0x24, injectData, 57, "UChar")
    NumPut(0xC3, injectData, 58, "UChar")
    writeRaw(hGTA, pInjectFunc, &injectData, dwLen)
    if(ErrorLevel)
        return 0
    hThread := createRemoteThread(hGTA, 0, 0, pInjectFunc, 0, 0, 0)
    if(ErrorLevel)
        return 0
    waitForSingleObject(hThread, 0xFFFFFFFF)
    closeProcess(hThread)
    return (readDWORD(hGTA, pParam2) ? 1 : 0)
}

IsPlayerVisible(ped)
{
    If(!checkHandles())
       return false
    dwFunc := 0x536BC0
    dwLen := 16
    VarSetCapacity(injectData, dwLen, 0)         
    NumPut(0xB9, injectData, 0, "UChar")    ;mov ecx   
    NumPut(ped, injectData, 1, "UInt")   
    NumPut(0xE8, injectData, 5, "UChar")    ;call   
    offset := dwFunc - (pInjectFunc + 10)
    NumPut(offset, injectData, 6, "Int")
    ; return value
    NumPut(0xA2, injectData, 10, "UChar") ; mov bReturn, al
    NumPut(pParam1, injectData, 11, "Int")
    NumPut(0xC3, injectData, 15, "UChar") ; retn
    writeRaw(hGTA, pInjectFunc, &injectData, dwLen)
    hThread := createRemoteThread(hGTA, 0, 0, pInjectFunc, 0, 0, 0)
    waitForSingleObject(hThread, 0xFFFFFFFF)
    closeProcess(hThread)
    return readMem(hGTA, pParam1, 1, "UChar")
}

getTargetPlayerHealth(player) ; dwPed or playerid
{
    if(!checkHandles())
        return 0
    if (player is integer) and (player >= 0) and (player <= 999)
        player := getPedById(player)
    if(!player)
        return 0
    return readMem(hGTA, player + 0x540, 2, "byte")
}

getTargetPlayerArmour(player) ; dwPed or playerid
{
    if(!checkHandles())
        return 0
    if (player is integer) and (player >= 0) and (player <= 999)
        player := getPedById(player)
    if(!player)
        return 0
    return readMem(hGTA, player + 0x548, 2, "byte")
}

getTargetPlayerWeaponModel(player) ; dwPed or playerid
{
    if(!checkHandles())
        return 0
    if (player is integer) and (player >= 0) and (player <= 999)
        player := getPedById(player)
    if(!player)
        return 0
    model := readMem(hGTA, player + 0x740, 2, "byte")
    if(model == 65535)
        return 0
    return model
}

CJ()
{
    if(!checkHandles())
        return false
    SIZE := 5
    dwFunc := dwSAMP + 0x15860
    offset := dwFunc - (pInjectFunc + SIZE)
    VarSetCapacity(inject, SIZE + 1, 0)
    NumPut(0xE8, inject, 0, "UChar") ; call
    NumPut(offset, inject, 1, "Int")
    NumPut(0xC3, inject, 5, "UChar") ; ret
    writeRaw(hGTA, pInjectFunc, &inject, SIZE + 1)
    hThread := createRemoteThread(hGTA, 0, 0, pInjectFunc, 0, 0, 0)
    waitForSingleObject(hThread, 0xFFFFFFFF)
    closeProcess(hThread)
    return true
}

getChatLineColor(line := 0, isHex := true) {
    ; 0x152 - offset for first message
    ; 0xFC - size of a full message
    ; 0xD4 - size of a string message
    ; 99 - max count of a messages
    if(!checkHandles())
        return -1
    dwAddress := readDWORD(hGTA, dwSAMP + ADDR_SAMP_CHATMSG_PTR)
    if ErrorLevel
        return -1
    clAddress := dwAddress + 0x152 + ((99-line) * 0xFC) + 0xD4
    if ErrorLevel
        return -1
    color := readMem(hGTA, clAddress, 3, "byte")
    if ErrorLevel
        return -1
    if isHex
        return inttohex(color)
    return color
}

setChatLineColor(color, line := 0) {
    if(!checkHandles())
        return false
    if color is not integer
    {
        while(substr(color, 1, 1) == "0")
            color := substr(color, 2)
        color := "0x" color
        if strlen(color) != 8
            return false ; разрешено 3 байта (6 символов + 2 это 0x)
    } else if(color > 16777215)
        return false ; цвет не может превышать 3 байта
    dwAddress := readDWORD(hGTA, dwSAMP + ADDR_SAMP_CHATMSG_PTR)
    if ErrorLevel
        return false
    clAddress := dwAddress + 0x152 + ((99-line) * 0xFC) + 0xD4
    if ErrorLevel
        return false
    writeMemory(hGTA, clAddress, color, 3, "byte")
    if ErrorLevel
        return false
    sendinput {f7 3} ; 3 - без соба, 4 - есть собейт
    return true
}

getChatLineTimestamp(line := 0, unixtime := true) {
    ; 0x152 - offset for first message
    ; 0xFC - size of a full message
    ; 0x20 - offset from timestamp to message
    ; 99 - max count of a messages
    if(!checkHandles())
        return -1
    dwAddress := readDWORD(hGTA, dwSAMP + ADDR_SAMP_CHATMSG_PTR)
    if ErrorLevel
        return -1
    tsAddress := dwAddress + 0x152 + ((99-line) * 0xFC) - 0x20
    if ErrorLevel
        return -1
    timestamp := readMem(hGTA, tsAddress, 4, "int")
    if ErrorLevel
        return -1
    ; timestamp += (A_Now - A_NowUTC)
    if unixtime
        return timestamp
    s = 1970
    s += timestamp,s
    ; return [ substr(s, 1, 4), substr(s, 5, 2), substr(s, 7, 2), substr(s, 9, 2), substr(s, 11, 2), substr(s, 13, 2) ] ; [Y,M,D,HH,MM,SS]
    return [ substr(s, 9, 2) , substr(s, 11, 2) , substr(s, 13, 2) , substr(s, 7, 2) , substr(s, 5, 2) , substr(s, 1, 4) ] ; [HH,MM,SS,D,M,Y]
}

setChatLineTimestamp(timestamp, line := 0) {
    if(!checkHandles())
        return false
    if timestamp is float
        timestamp := floor(timestamp)
    if substr(timestamp, 1, 1) == "+" or substr(timestamp, 1, 1) == "-"
        timestamp := getChatLineTimestamp(line) + timestamp
    if timestamp is not integer
        return false
    dwAddress := readDWORD(hGTA, dwSAMP + ADDR_SAMP_CHATMSG_PTR)
    if ErrorLevel
        return false
    tsAddress := dwAddress + 0x152 + ((99-line) * 0xFC) - 0x20
    if ErrorLevel
        return false
    writeMemory(hGTA, tsAddress, timestamp, 4, "int")
    if ErrorLevel
        return -1
    sendinput {f7 3} ; 3 - без соба, 4 - есть собейт
    return true
}

NOP_SetPlayerPos(tog := -1)
{
    if(!checkHandles())
        return -1
    dwAddress := dwSAMP+0x15970
    byte := readMem(hGTA, dwAddress, 1, "byte")
    if((tog == -1 && byte != 195) || tog == true || tog == 1)
    {
        writeBytes(hGTA, dwAddress, "C390")
        return true
    } else if((tog == -1 && byte == 195) || !tog)
    {
        writeBytes(hGTA, dwAddress, "E910")
        return false
    }
    return -1
}

removeChatLine(line := 0)
{
    if(!checkHandles())
        return false
    if(!dwAddress := readDWORD(hGTA, dwSAMP + ADDR_SAMP_CHATMSG_PTR))
        return false
    loop % 100 - line
    {
        a := ""
        dwLine := dwAddress + 0x132 + ( (99 - A_Index - line) * 0xFC )
        loop 0xFC
        {
            byte := substr(inttohex(Memory_ReadByte(hGTA, dwLine++)), 3)
            a .= (strlen(byte) == 1 ? "0" : "") byte
        }
        dwLine := dwAddress + 0x132 + ( (100 - A_Index - line) * 0xFC )
        writeBytes(hGTA, dwLine, a)
    }
    sendinput {f7 3} ; 3 - без соба, 4 - есть собейт
    return true
}

getChatLineEx(line := 0) {
    ; 0x152 - offset for first message
    ; 0xFC - size of a message
    ; 99 - max count of a messages
    if(!checkHandles())
        return
    dwPtr := dwSAMP + ADDR_SAMP_CHATMSG_PTR
    dwAddress := readDWORD(hGTA, dwPtr)
    if(ErrorLevel)
        return
    msg := readString(hGTA, dwAddress + 0x152 + ( (99-line) * 0xFC), 0xFC)
    if(ErrorLevel)
        return
    return msg
}

PrintLow(text, time) {
    ;0x69F1E0 = PrintLowPriorityMessage(const char* text, int time_in_ms, int unknown1 = 1, int unknown2 = 1);
    if(!checkHandles())
        return -1
    dwFunc := 0x69F1E0
    callwithparams(hGta, dwFunc, [["s",text], ["i", time], ["i", 1], ["i", 1]], true)
}

getChatState(state := -1)
{
    if(!checkHandles())
        return false
    dwAddr := readDWORD(hGTA, dwSAMP + ADDR_SAMP_CHATMSG_PTR) + 8
    if state between 0 and 2
    {
        writeByte(hGTA, dwAddr, state)
        sendinput {f7 3}
    }
    return Memory_ReadByte(hGTA, dwAddr)
}

GetBonePosition(ped,boneId){
    callWithParamsBonePos(0x5E4280, [["i", ped],["i", pParamBonePos1],["i",boneId],["i", 1]], false, true)
    return [readFloat(hGTA, pParamBonePos1), readFloat(hGTA, pParamBonePos1 + 4), readFloat(hGTA, pParamBonePos1 + 8)]
}
    callWithParamsBonePos(dwFunc, aParams, bCleanupStack = true,  thiscall = false) {
    validParams := 0
    i := aParams.MaxIndex()
    dwLen := i * 5 + 5 + 1
    if(bCleanupStack)
    dwLen += 3
    VarSetCapacity(injectData, i * 5 + 5 + 3 + 1, 0)
    i_ := 1
    while(i > 0) {
    if(aParams[i][1] != "") {
        dwMemAddress := 0x0
    if(aParams[i][1] == "p") {
        dwMemAddress := aParams[i][2]
    } else if(aParams[i][1] == "s") {
        if(i_>3)
            return false
        dwMemAddress := pParamBonePos%i_%
        writeString(hGTA,dwMemAddress, aParams[i][2])
        if(ErrorLevel)
            return false
        i_ += 1
        } else if(aParams[i][1] == "i") {
            dwMemAddress := aParams[i][2]
        } else {
            return false
        }
            NumPut((thiscall && i == 1 ? 0xB9 : 0x68), injectData, validParams * 5, "UChar")
            NumPut(dwMemAddress, injectData, validParams * 5 + 1, "UInt")
            validParams += 1
        }
            i -= 1
        }
            offset := dwFunc - ( pInjectFuncBonePos + validParams * 5 + 5 )
            NumPut(0xE8, injectData, validParams * 5, "UChar")
            NumPut(offset, injectData, validParams * 5 + 1, "Int")
            if(bCleanupStack) {
            NumPut(0xC483, injectData, validParams * 5 + 5, "UShort")
            NumPut(validParams*4, injectData, validParams * 5 + 7, "UChar")
            NumPut(0xC3, injectData, validParams * 5 + 8, "UChar")
            } else {
                NumPut(0xC3, injectData, validParams * 5 + 5, "UChar")
            }
            writeRaw(hGTA, pInjectFuncBonePos, &injectData, dwLen)
            if(ErrorLevel)
                return false
            hThread := createRemoteThread(hGTA, 0, 0, pInjectFuncBonePos, 0, 0, 0)
            if(ErrorLevel)
                return false
            waitForSingleObject(hThread, 0xFFFFFFFF)
            closeProcess(hThread)
            return true
        }
getVehicleMaxPassengers()
{
    if(!checkHandles())
        return -1
    if(!CVeh := readDWORD(hGTA, ADDR_VEHICLE_PTR))
        return -1
    return readMem(hGTA, CVeh + 0x488, 1, "byte")
}

getVehiclePassenger(place)
{
    ; возвращает указатель на игрока
    ; 0 - водитель, от 1 до 8 - пассажирские места
    if(!checkHandles())
        return -1
    if(!CVeh := readDWORD(hGTA, ADDR_VEHICLE_PTR))
        return -1
    return readDWORD(hGTA, CVeh + 0x460 + (place * 4))
}

getVehiclePassengerId(place)
{
    CPed := getVehiclePassenger(place)
    return getIdByPed(CPed)
}

getLastDamagePed(ByRef Ped := "", ByRef Weapon := "")
{
    if(!checkHandles())
        return -1
    if(!CPed := readDWORD(hGTA, ADDR_CPED_PTR))
        return -1
    if(!dwPed := readDWORD(hGTA, CPed + 0x764))
        return -1
    Ped := getIdByPed(dwPed)
    Weapon := readMem(hGTA, CPed + 0x760, 4, "int")
    return Ped
}

getKillStat(ByRef IsEnabled := "")
{
    if(!checkHandles())
        return false
    a := []
    klist := readDWORD(hGTA, dwSAMP + 0x21A0EC)
    isEnabled := readMem(hGTA, klist, 4, "int")
    klist += 4
    loop 5
    {
        szKiller := readString(hGTA, klist, 25)
        szVictim := readString(hGTA, (klist += 25), 25)
        clKillerColor := inttohex(readMem(hGTA, (klist += 25), 4, "uint"))
        clVictimColor := inttohex(readMem(hGTA, (klist += 4), 4, "uint"))
        byteType := Memory_ReadByte(hGTA, (klist += 4))
        klist++
        a.Insert([szKiller, szVictim, clKillerColor, clVictimColor, byteType])
    }
    return a
}

setFireImmunity(state)
{
    if(!checkHandles())
        return
    writeMemory(hGTA, 0xB7CEE6, (state ? 1 : 0), 1, "byte")
}

setInfiniteRun(state)
{
    if(!checkHandles())
        return
    writeMemory(hGTA, 0xB7CEE4, (state ? 1 : 0), 1, "byte")
}

isMarkerSetup()
{
    if(!checkHandles())
        return -1
    return readMem(hGTA, 0xBA6774, 1, "byte")
}

multVehicleSpeed(MultValue := 1.01, SleepTime := 10, MaxSpeedX := 2.0, MaxSpeedY := 2.0)
{
    if(multVehicleSpeed_tick + SleepTime > A_TickCount)
        return false
    multVehicleSpeed_tick := A_TickCount
    
    if(!checkHandles())
        return false
    if(!dwAddr := readDWORD(hGTA, ADDR_VEHICLE_PTR))
        return false
    
    if(!MultValue)
    {
        writeFloat(hGTA, dwAddr + ADDR_VEHICLE_X, 0.0)
        writeFloat(hGTA, dwAddr + ADDR_VEHICLE_Y, 0.0)
        return true
    }
    
    fSpeedX := readMem(hGTA, dwAddr + ADDR_VEHICLE_X, 4, "float")
    fSpeedY := readMem(hGTA, dwAddr + ADDR_VEHICLE_Y, 4, "float")
    
    if(abs(fSpeedX) <= MaxSpeedX)
        writeFloat(hGTA, dwAddr + ADDR_VEHICLE_X, fSpeedX * MultValue)
    if(abs(fSpeedY) <= MaxSpeedY)
        writeFloat(hGTA, dwAddr + ADDR_VEHICLE_Y, fSpeedY * MultValue)
    
    return true
}


togglekillstat(state) 
{
    if(!checkHandles())
        return false
    dwKillptr := readDWORD(hGTA, dwSAMP + SAMP_KILLSTAT_OFFSET)
    if(ErrorLevel || dwKillptr == 0) {
        ErrorLevel := ERROR_READ_MEMORY
        return false
    }
    
    writeBytes(hGTA, dwKillptr, state)
    if(ErrorLevel) {
  ErrorLevel := ERROR_WRITE_MEMORY
  return -1
    }
    return true
}

setkillstatwidth(width)
{
   if(!checkHandles())
        return false
        
    dwKillptr := readDWORD(hGTA, dwSAMP + SAMP_KILLSTAT_OFFSET)
    if(ErrorLevel || dwKillptr == 0) {
        ErrorLevel := ERROR_READ_MEMORY
        return false
    }
    
    writeBytes(hGTA, dwKillptr + 0x133, width)
    if(ErrorLevel) {
  ErrorLevel := ERROR_WRITE_MEMORY
  return false
    }
    return true
}

movekillstat(x)
{
    if(!checkHandles())
        return false
        
    dwKillptr := readDWORD(hGTA, dwSAMP + SAMP_KILLSTAT_OFFSET)
    if(ErrorLevel || dwKillptr == 0) {
        ErrorLevel := ERROR_READ_MEMORY
        return false
    }
    
    writeBytes(hGTA, dwKillptr + 0x12B, x)
    if(ErrorLevel) {
  ErrorLevel := ERROR_WRITE_MEMORY
  return false
    }
    return true
}

setdistkillstat(int)
{
        if(!checkHandles())
        return false
        
    dwKillptr := readDWORD(hGTA, dwSAMP + SAMP_KILLSTAT_OFFSET)
    if(ErrorLevel || dwKillptr == 0) {
        ErrorLevel := ERROR_READ_MEMORY
        return false
    }
    
    writeBytes(hGTA, dwKillptr + 0x12F, int)
    if(ErrorLevel) {
  ErrorLevel := ERROR_WRITE_MEMORY
  return false
    }
    return true
}

getWeaponSlotById(id)
{
    if id between 2 and 9
        slot := 1
    if id between 10 and 15
        slot := 10
    if id in 16,17,18,39
        slot := 8
    if id between 22 and 24
        slot := 2
    if id between 25 and 27
        slot := 3
    if id in 28,29,32
        slot := 4
    if id in 30,31
        slot := 5
    if id in 33,34
        slot := 6
    if id between 35 and 38
        slot := 7
    if id == 40
        slot := 12
    if id between 41 and 43
        slot := 9
    if id between 44 and 46
        slot := 11
}

isPlayerCrouch()
{
    if(!checkHandles())
        return -1
    if(!CPed := readDWORD(hGTA, ADDR_CPED_PTR))
        return -1
    state := readMem(hGTA, CPed + 0x46F, 1, "byte")
    if(state == 132)
        return 1
    if(state == 128)
        return 0
    return -1
}

setDialogState(tog)
{
    if(!checkHandles())
        return false
    
    dwPointer := getDialogStructPtr()
    if(ErrorLevel || !dwPointer)
        return false
    
    writeMemory(hGTA, dwPointer + 0x28, (tog ? 1 : 0), 1, "byte")
    if(!tog)
        Send {f6}{esc}
    return true
}

toggleObjectDrawMode(tog := -1)
{
    if(!checkHandles())
        return -1
    byte := readMem(hGTA, dwSAMP + 0x69529, 1, "byte")
    if((tog == -1 && byte == 15) || tog == true || tog == 1)
    {
        writeBytes(hGTA, dwSAMP + 0x69529, "909090909090")
        return true
    } else if((tog == -1 && byte == 144) || !tog)
    {
        writeBytes(hGTA, dwSAMP + 0x69529, "0F84AE000000")
        Send {f6}{esc}
        return false
    }
    return -1
}

blurlevel(level := -1)
{
    if(!checkHandles())
        return -1
    if level between 0 and 255
        writeMemory(hGTA, 0x8D5104, level, 1, "byte")
    blur := readMem(hGTA, 0x8D5104, 1, "byte")
    return blur
}

toggleNoDamageByWeapon(tog := -1)
{
    if(!checkHandles())
        return -1
    byte := readMem(hGTA, 0x60A5BA, 1, "byte")
    if((tog == -1 && byte == 216) || tog == true || tog == 1)
    {
        writeBytes(hGTA, 0x60A5BA, "909090")
        return true
    } else if((tog == -1 && byte == 144) || !tog)
    {
        writeBytes(hGTA, 0x60A5BA, "D95E18")
        return false
    }
    addChatMessageEx(0xCC0000, "only for gta_sa.exe 1.0 us")
    return -1
}

toggleInvulnerability(tog := -1)
{
    if(!checkHandles())
        return -1
    byte := readMem(hGTA, 0x60A5BA, 1, "byte")
    if((tog == -1 && byte == 217) || tog == true || tog == 1)
    {
        writeBytes(hGTA, 0x4B3314, "909090")
        return true
    } else if((tog == -1 && byte == 144) || !tog)
    {
        writeBytes(hGTA, 0x4B3314, "D86504")
        return false
    }
    addChatMessageEx(0xCC0000, "only for gta_sa.exe 1.0 us")
    return -1
}

gmpatch()
{
    if(!checkHandles())
        return false
    a := writeMemory(hGTA, 0x4B35A0, 0x560CEC83, 4, "int")
    b := writeMemory(hGTA, 0x4B35A4, 0xF18B, 2, "byte")
    return (a && b)
}

toggleUnlimitedAmmo(tog := -1)
{
    if(!checkHandles())
        return -1
    byte := readMem(hGTA, 0x7428E6, 1, "byte")
    if((tog == -1 && byte == 255) || tog == true || tog == 1)
    {
        writeBytes(hGTA, 0x7428E6, "909090")
        return true
    } else if((tog == -1 && byte == 144) || !tog)
    {
        writeBytes(hGTA, 0x7428E6, "FF4E0C")
        return false
    }
    addChatMessageEx(0xCC0000, "only for gta_sa.exe 1.0 us")
    return -1
}

toggleNoReload(tog := -1)
{
    if(!checkHandles())
        return -1
    byte := readMem(hGTA, 0x7428B0, 1, "byte")
    if((tog == -1 && byte == 137) || tog == true || tog == 1)
    {
        writeBytes(hGTA, 0x7428B0, "909090")
        return true
    } else if((tog == -1 && byte == 144) || !tog)
    {
        writeBytes(hGTA, 0x7428B0, "894608")
        return false
    }
    addChatMessageEx(0xCC0000, "only for gta_sa.exe 1.0 us")
    return -1
}

toggleNoRecoil(tog := -1)
{
    if(!checkHandles())
        return -1
    byte := readMem(hGTA, 0x740450, 1, "byte")
    if((tog == -1 && byte == 216) || tog == true || tog == 1)
    {
        writeBytes(hGTA, 0x740450, "90909090909090909090")
        return true
    } else if((tog == -1 && byte == 144) || !tog)
    {
        writeBytes(hGTA, 0x740450, "D80D3C8B8500D84C241C")
        return false
    }
    addChatMessageEx(0xCC0000, "only for gta_sa.exe 1.0 us")
    return -1
}

toggleAntiBikeFall(tog := -1)
{
    if(!checkHandles())
        return -1
    byte := readMem(hGTA, 0x4BA3B9, 1, "byte")
    if((tog == -1 && byte == 15) || tog == true || tog == 1)
    {
        writeBytes(hGTA, 0x4BA3B9, "E9A703000090")
        return true
    } else if((tog == -1 && byte == 233) || !tog)
    {
        writeBytes(hGTA, 0x4BA3B9, "0F84A6030000")
        return false
    }
    addChatMessageEx(0xCC0000, "only for gta_sa.exe 1.0 us")
    return -1
}

toggleAntiCarEject(tog := -1)
{
    if(!checkHandles())
        return -1
    byte := readMem(hGTA, dwSAMP + 0x146E0, 1, "byte")
    if((tog == -1 && byte == 233) || tog == true || tog == 1)
    {
        writeBytes(hGTA, dwSAMP + 0x146E0, "C390909090")
        return true
    } else if((tog == -1 && byte == 195) || !tog)
    {
        writeBytes(hGTA, dwSAMP + 0x146E0, "E9D7722700")
        return false
    }
    return -1
}

toggleNoAnimations(tog := -1)
{
    if(!checkHandles())
        return -1
    byte := readMem(hGTA, dwSAMP + 0x16FA0, 1, "byte")
    if((tog == -1 && byte == 85) || tog == true || tog == 1)
    {
        writeMemory(hGTA, dwSAMP + 0x16FA0, 0xC3, 1, "byte")
        return true
    } else if((tog == -1 && byte == 195) || !tog)
    {
        writeMemory(hGTA, dwSAMP + 0x16FA0, 0x55, 1, "byte")
        return false
    }
    return -1
}

toggleMotionBlur(tog := -1)
{
    if(!checkHandles())
        return -1
    byte := readMem(hGTA, 0x704E8A, 1, "byte")
    if((tog == -1 && byte == 144) || tog == true || tog == 1)
    {
        writeBytes(hGTA, 0x704E8A, "E811E2FFFF")
        return true
    } else if((tog == -1 && byte == 232) || !tog)
    {
        writeBytes(hGTA, 0x704E8A, "9090909090")
        return false
    }
    addChatMessageEx(0xCC0000, "only for gta_sa.exe 1.0 us")
    return -1
}

writeBytes(handle, address, bytes)
{
    length := strlen(bytes) / 2
    VarSetCapacity(toInject, length, 0)
    Loop %length%
    {
        byte := "0x" substr(bytes, ((A_Index - 1) * 2) + 1, 2)
        NumPut(byte, toInject, A_Index - 1, "uchar")
    }
    return writeRaw(handle, address, &toInject, length)
}

setPlayerFreeze(status) {
    if(!checkHandles())
        return -1
    
    dwCPed := readDWORD(hGTA, 0xB6F5F0)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    dwAddr := dwCPed + 0x42 
	writeString(hGTA, dwAddr, status)
	if(ErrorLevel) {
		ErrorLevel := ERROR_WRITE_MEMORY
		return -1		
	}     
    ErrorLevel := ERROR_OK
    return true
}

getPlayerAnim()
{
    if(!checkHandles())
        return false
    dwPointer := readDWORD(hGTA, dwSAMP + 0x13D190)
    anim := readMem(hGTA, dwPointer + 0x2F4C, 2, "byte")
    return anim
}

setPlayerHealth(amount) {
    if(!checkHandles())
        return -1
    
    dwCPedPtr := readDWORD(hGTA, ADDR_CPED_PTR)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    dwAddr := dwCPedPtr + ADDR_CPED_HPOFF
    writeFloat(hGTA, dwAddr, amount)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    ErrorLevel := ERROR_OK
    return true
}

setPlayerArmor(amount) {
    if(!checkHandles())
        return -1
    
    dwCPedPtr := readDWORD(hGTA, ADDR_CPED_PTR)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    dwAddr := dwCPedPtr + ADDR_CPED_ARMOROFF
    writeFloat(hGTA, dwAddr, amount)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    ErrorLevel := ERROR_OK
    return true
}

setVehicleHealth(amount) {
    if(!checkHandles())
        return -1
    
    dwVehPtr := readDWORD(hGTA, ADDR_VEHICLE_PTR)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    dwAddr := dwVehPtr + ADDR_VEHICLE_HPOFF
    writeFloat(hGTA, dwAddr, amount)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    ErrorLevel := ERROR_OK
    return true
}

getDialogIndex() {
    dwPointer := getDialogStructPtr()
    if (ErrorLevel || !dwPointer)
        return false
    
    dwPointer := readDWORD(hGTA, dwPointer + SAMP_DIALOG_PTR2_OFFSET)
    if (ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return 0
    }
    
    index := readMem(hGTA, dwPointer + 0x143, 1, "Byte")
    if (ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return false
    }
    
    ErrorLevel := ERROR_OK
    return index + 1
}

isDialogButtonSelected(btn := 1) {
    dwPointer := getDialogStructPtr()
    if (ErrorLevel || !dwPointer)
        return false
    
    dwPointer := readDWORD(hGTA, dwPointer + SAMP_DIALOG_PTR2_OFFSET)
    if (ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return 0
    }
    
    offset := (btn == 1 ? 0x165 : 0x2C5)
    sel := readMem(hGTA, dwPointer + offset, 1, "Byte")
    if (ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return false
    }
    
    ErrorLevel := ERROR_OK
    return sel
}

getServerHour() {
    if(!checkHandles())
        return -1
    
    dwGTA := getModuleBaseAddress("gta_sa.exe", hGTA)
    Hour := readMem(hGTA, 0xB70153, 1, "Int")
    if (Hour <= 9) {
        FixHour = 0%Hour%
        return FixHour
    }
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    ErrorLevel := ERROR_OK    
    return Hour
}
getsexbyskin(skin) 
{ 
if skin in 1,2,3,4,5,6,7,8,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,32,33,34,35,36,37,42,43,44,45,46,47,48,49,50,51,52,57,58,59,60,61,62,66,67,68,70,71,72,73,79,80,81,82,83,84,86,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,132,133,134,135,136,137,142,143,144,146,147,149,153,154,155,156,158,159,160,161,162,163,164,165,166,167,168,170,171,173,174,175,176,177,179,180,181,182,183,184,185,186,187,188,189,200,202,203,204,206,208,209,210,212,213,217,220,221,222,223,227,228,229,230,234,235,236,239,240,241,242,247,248,249,250,252,253,254,255,258,259,260,261,262,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,299,300,301,302,303,304,305,310,311
    return 1 
if skin in 9,10,11,12,13,31,38,39,40,41,53,54,55,56,63,64,65,69,75,76,77,85,87,88,89,90,91,92,93,129,130,131,138,139,140,141,143,144,145,148,150,151,152,157,169,172,178,190,191,192,193,194,195,196,197,198,199,201,205,207,211,214,215,216,218,219,224,225,226,231,232,233,237,238,243,244,245,246,251,256,257,263,298,306,307,308,309 
    return 2 
else 
    return 0 
}

set_player_armed_weapon_to(weaponid)
{
    c := getPlayerWeaponId()
    WinGet, gtapid, List, GTA:SA:MP
    SendMessage, 0x50,, 0x4090409,, GTA:SA:MP
    Loop
    {
        ControlSend,, {E down}, ahk_id %gtapid1%
        Sleep, 5
        ControlSend,, {E up}, ahk_id %gtapid1%
        if(getPlayerWeaponId() == c || getPlayerWeaponId() == weaponid)
            break
    }
}

getZoneByName(zName, ByRef CurZone ) { 
    if ( bInitZaC == 0 ) 
    { 
        initZonesAndCities() 
        bInitZaC := 1 
    } 
    Loop % nZone-1 
    { 
        if (zone%A_Index%_name == zName) 
        { 
            ErrorLevel := ERROR_OK 
            CurZone[1] := zone%A_Index%_name 
            CurZone[2] := %A_Index% 
            CurZone[3,1,1] := zone%A_Index%_x1 
            CurZone[3,1,2] := zone%A_Index%_y1 
            CurZone[3,1,3] := zone%A_Index%_z1 
            CurZone[3,2,1] := zone%A_Index%_x2 
            CurZone[3,2,2] := zone%A_Index%_y2 
            CurZone[3,2,3] := zone%A_Index%_z2 
            return true 
        } 
    } 
    ErrorLevel := ERROR_ZONE_NOT_FOUND 
    return "Unknown" 
} 
; PointPos[1] - X Point 
; PointPos[2] - Z Point 
getCenterPointToZone(zName, ByRef PointPos) { 
    getZoneByName(zName, CurZone) 
    PointPos[1] := 125 + CurZone[3,1,1] 
    PointPos[2] := 125 + CurZone[3,1,2] 
    return true 
}

getDialogLineNumber() {
    dwPointer := getDialogStructPtr()
    if (ErrorLevel || !dwPointer)
        return 0
    dwPointer := readDWORD(hGTA, dwPointer + SAMP_DIALOG_PTR2_OFFSET)
    if (ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return 0
    }
    count := readMem(hGTA, dwPointer + SAMP_DIALOG_LINENUMBER_OFFSET, 4, "UInt")
    if (ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return 0
    }
    return count//16777216+1
}

getServerMinute() {
    if(!checkHandles())
        return -1
    
    dwGTA := getModuleBaseAddress("gta_sa.exe", hGTA)
    Minute := readMem(hGTA, 0xB70152, 1, "Int")
    if (Minute <= 9) {
        FixMinute = 0%Minute%
        return FixMinute
    }
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    ErrorLevel := ERROR_OK    
    return Minute
}

getCameraCoordinates() {
    if(!checkHandles())
        return false

    fX := readFloat(hGTA, 0xB6F9CC)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return ""
    }
    
    fY := readFloat(hGTA, 0xB6F9D0)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return ""
    }
    
    fZ := readFloat(hGTA, 0xB6F9D4)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return ""
    }
    
    ErrorLevel := ERROR_OK
    return [fX, fY, fZ]
}

getPlayerPosById(dwId) {
    dwId += 0
    dwId := Floor(dwId)
    if(dwId < 0 || dwId >= SAMP_PLAYER_MAX)
        return ""
    
    if(iRefreshScoreboard+iUpdateTick > A_TickCount)
    {
        if(oScoreboardData[dwId])
        {
   if(oScoreboardData[dwId].HasKey("PED"))
    return getPedCoordinates(oScoreboardData[dwId].PED)
   if(oScoreboardData[dwId].HasKey("MPOS"))
    return oScoreboardData[dwId].MPOS
  }
        return ""
    }
    
    if(!updateOScoreboardData())
        return ""
    
    if(oScoreboardData[dwId])
    {
  if(oScoreboardData[dwId].HasKey("PED"))
   return getPedCoordinates(oScoreboardData[dwId].PED)
  if(oScoreboardData[dwId].HasKey("MPOS"))
   return oScoreboardData[dwId].MPOS
    }
    return ""
}

HexToDecOne(Hex)
{
    if (InStr(Hex, "0x") != 1)
    Hex := "0x" Hex
    return, Hex + 0
}

HexToDecTwo(hex)
{
    VarSetCapacity(dec, 66, 0)
    , val := DllCall("msvcrt.dll\_wcstoui64", "Str", hex, "UInt", 0, "UInt", 16, "CDECL Int64")
    , DllCall("msvcrt.dll\_i64tow", "Int64", val, "Str", dec, "UInt", 10, "CDECL")
    return dec
}
hex2rgb(CR)
{
    NumPut((InStr(CR, "#") ? "0x" SubStr(CR, 2) : "0x") SubStr(CR, -5), (V := "000000"))
    return NumGet(V, 2, "UChar") "," NumGet(V, 1, "UChar") "," NumGet(V, 0, "UChar")
}
rgb2hex(R, G, B, H := 1)
{
    static U := A_IsUnicode ? "_wcstoui64" : "_strtoui64"
    static V := A_IsUnicode ? "_i64tow"    : "_i64toa"
    rgb := ((R << 16) + (G << 8) + B)
    H := ((H = 1) ? "#" : ((H = 2) ? "0x" : ""))
    VarSetCapacity(S, 66, 0)
    value := DllCall("msvcrt.dll\" U, "Str", rgb , "UInt", 0, "UInt", 10, "CDECL Int64")
    DllCall("msvcrt.dll\" V, "Int64", value, "Str", S, "UInt", 16, "CDECL")
    return H S
}
GetCoordsSamp(ByRef ResX, ByRef ResY) 
{
    MouseGetPos, PosX, PosY
    PosXProc := PosX * 100 / A_ScreenWidth
    PosYProc := PosY * 100 / A_ScreenHeight
    ResX := PosXProc * 8
    ResY := PosYProc * 6
}
getVehicleIdServer(address=0x13C298, datatype="int", length=4, offset=0)
{
    if (isPlayerDriver() != "-1" or isPlayerInAnyVehicle() != "0")
    {
    Process, Exist, gta_sa.exe
    PID_GTA := ErrorLevel
    VarSetCapacity(me32, 548, 0)
    NumPut(548, me32)
    snapMod := DllCall("CreateToolhelp32Snapshot", "Uint", 0x00000008, "Uint", PID_GTA)
    If (snapMod = -1)
        Return 0
    If (DllCall("Module32First", "Uint", snapMod, "Uint", &me32))
{
  Loop
        {
            If (!DllCall("lstrcmpi", "Str", "samp.dll", "UInt", &me32 + 32)) {
                DllCall("CloseHandle", "UInt", snapMod)
                key:= NumGet(&me32 + 20)
                WinGet, PID_SAMP, PID, GTA:SA:MP
                hwnd_samp := DllCall("OpenProcess","Uint",0x1F0FFF,"int",0,"int", PID_SAMP)
                VarSetCapacity(readvalue,length, 0)
                DllCall("ReadProcessMemory","Uint",hwnd_samp,"Uint",key+address+offset,"Str",readvalue,"Uint",length,"Uint *",0)
                finalvalue := NumGet(readvalue,0,datatype)
                DllCall("CloseHandle", "int", hwnd_samp)
                return finalvalue
            }
        }
    Until !DllCall("Module32Next", "Uint", snapMod, "UInt", &me32)
    }
    DllCall("CloseHandle", "Uint", snapMod)
    }
    else
        Return 0
}
; Визуально меняет ник любого игрока
setPlayerName(playerid, newnick) {
    if(!checkHandles() || !strlen(newnick))
        return 0

    dwAddress := readDWORD(hGTA, dwSAMP + SAMP_INFO_OFFSET)
    if(ErrorLevel || dwAddress==0) {
        ErrorLevel := ERROR_READ_MEMORY
        return 0
    }
    
    dwAddress := readDWORD(hGTA, dwAddress + SAMP_PPOOLS_OFFSET)
    if(ErrorLevel || dwAddress==0) {
        ErrorLevel := ERROR_READ_MEMORY
        return 0
    }
    
    dwPlayers := readDWORD(hGTA, dwAddress + SAMP_PPOOL_PLAYER_OFFSET)
    if(ErrorLevel || dwPlayers==0) {
        ErrorLevel := ERROR_READ_MEMORY
        return 0
    }

    dwRemoteplayer := readDWORD(hGTA, dwPlayers+SAMP_PREMOTEPLAYER_OFFSET+playerid*4)      ;pRemotePlayer
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return 0
    }
        
    if(dwRemoteplayer==0)
        return 0
        
    dwTemp := readMem(hGTA, dwRemoteplayer + SAMP_ISTRLENNAME___OFFSET, 4, "Int")
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return 0
    }
    sUsername := ""
    if(dwTemp <= 0xf)
    {
        sUsername := readString(hGTA, dwRemoteplayer+SAMP_SZPLAYERNAME_OFFSET, 16)
        if(ErrorLevel) {
            ErrorLevel := ERROR_READ_MEMORY
            return 0
        }
        writeString(hGTA, dwRemoteplayer+SAMP_SZPLAYERNAME_OFFSET, newnick)
    }
    else {
        dwAddress := readDWORD(hGTA, dwRemoteplayer + SAMP_PSZPLAYERNAME_OFFSET)
        if(ErrorLevel || dwAddress==0) {
            ErrorLevel := ERROR_READ_MEMORY
            return 0
        }
        sUsername := readString(hGTA, dwAddress, 25)
        if(ErrorLevel) {
            ErrorLevel := ERROR_READ_MEMORY
            return 0
        }
        writeString(hGTA, dwAddress, newnick)
    }
    
    ErrorLevel := ERROR_OK
    return 1
}

HexToDec(str)
{   
   local newStr := ""
   static comp := {0:0, 1:1, 2:2, 3:3, 4:4, 5:5, 6:6, 7:7, 8:8, 9:9, "a":10, "b":11, "c":12, "d":13, "e":14, "f":15}
   StringLower, str, str
   str := RegExReplace(str, "^0x|[^a-f0-9]+", "")
   Loop, % StrLen(str)
       newStr .= SubStr(str, (StrLen(str)-A_Index)+1, 1)
   newStr := StrSplit(newStr, "")
   local ret := 0
   for i,char in newStr
       ret += comp[char]*(16**(i-1))
   return ret
}

addChatMessageEx(Color, wText) {
   wText := "" wText

   if(!checkHandles())
       return false
   
    VarSetCapacity(data2, 4, 0)
   NumPut(HexToDec(Color),data2,0,"Int")
    
   Addrr := readDWORD(hGTA, dwSAMP+ADDR_SAMP_CHATMSG_PTR)
   
   VarSetCapacity(data1, 4, 0)
   NumPut(readDWORD(hGTA, Addrr + 0x12A), data1,0,"Int") 
   
   WriteRaw(hGTA, Addrr + 0x12A, &data2, 4)
    
   dwFunc := dwSAMP + FUNC_SAMP_ADDTOCHATWND
   dwChatInfo := readDWORD(hGTA, dwSAMP + ADDR_SAMP_CHATMSG_PTR)
   if(ErrorLevel) {
       ErrorLevel := ERROR_READ_MEMORY
       return false
   }
   
   callWithParams(hGTA, dwFunc, [["p", dwChatInfo], ["s", wText]], true)
   WriteRaw(hGTA, Addrr + 0x12A, &data1, 4)
   
   ErrorLevel := ERROR_OK
    
   return true
}

connect(IP) {
    setIP(IP)
    restartGameEx()
    disconnectEx()
    Sleep 1000
    setrestart()
    Return
}

WriteProcessMemory(title,addresse,wert,size)  
{ 
	VarSetCapacity(idvar,32,0) 
	VarSetCapacity(processhandle,32,0) 
	VarSetCapacity(value, 32, 0) 
	NumPut(wert,value,0,Uint) 
	address=%addresse% 	
	WinGet ,idvar,PID,%title% 
	processhandle:=DllCall("OpenProcess","Uint",0x38,"int",0,"int",idvar) 
	Bvar:=DllCall("WriteProcessMemory","Uint",processhandle,"Uint",address+0,"Uint",&value,"Uint",size,"Uint",0) 
}

setCoordinates(x, y, z, Interior) {
    if(!checkHandles())
        return False

    dwAddress := readMem(hGTA, ADDR_SET_POSITION)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        Return False
    }

    dwAddress := readMem(hGTA, dwAddress + ADDR_SET_POSITION_OFFSET)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        Return False
    }

    Sleep 100

    writeByte(hGTA, ADDR_SET_INTERIOR_OFFSET, Interior)
    if(ErrorLevel) {
        ErrorLevel := ERROR_WRITE_MEMORY
        Return False
    }

    writeFloat(hGTA, dwAddress + ADDR_SET_POSITION_X_OFFSET, x)
    if(ErrorLevel) {
        ErrorLevel := ERROR_WRITE_MEMORY
        Return False
    }

    writeFloat(hGTA, dwAddress + ADDR_SET_POSITION_Y_OFFSET, y)
    if(ErrorLevel) {
        ErrorLevel := ERROR_WRITE_MEMORY
        Return False
    }

    writeFloat(hGTA, dwAddress + ADDR_SET_POSITION_Z_OFFSET, z)
    if(ErrorLevel) {
        ErrorLevel := ERROR_WRITE_MEMORY
        Return False
    }

    Return True
}
colorhud(colorhud) 
{ 
    VarSetCapacity(idvar,32,0) 
    VarSetCapacity(processhandle,32,0) 
    VarSetCapacity(value, 32, 0) 
    NumPut(colorhud,value,0,Uint) 
    address=0xBAB230
    WinGet ,idvar,PID,GTA:SA:MP
    processhandle:=DllCall("OpenProcess","Uint",0x38,"int",0,"int",idvar) 
    Bvar:=DllCall("WriteProcessMemory","Uint",processhandle,"Uint",address+0,"Uint",&value,"Uint","4","Uint",0) 
}

; Смена Ip Сервера
setIP(IP) {
    if(!checkHandles())
        return False

    dwAddress := readDWORD(hGTA, dwSAMP + SAMP_INFO_OFFSET)
    if(ErrorLevel || dwAddress==0) {
        ErrorLevel := ERROR_READ_MEMORY
        return False
    }

    writeString(hGTA, dwAddress + SAMP_SZIP_OFFSET, IP)
    if(ErrorLevel) {
        ErrorLevel := ERROR_WRITE_MEMORY
        return False
    }

    return True
}

; set nickname
setUsername(Username) {
    if(!checkHandles())
        return False

    dwAddress := dwSAMP + ADDR_SAMP_USERNAME
    writeString(hGTA, dwAddress, Username)
    if(ErrorLevel) {
        ErrorLevel := ERROR_WRITE_MEMORY
        return False
    }

    ErrorLevel := ERROR_OK
    return True
}

setChatLine(line, msg) {
	if(!checkHandles())
		return -1

	dwPtr := dwSAMP + ADDR_SAMP_CHATMSG_PTR
	dwAddress := readDWORD(hGTA,dwPtr)
	if(ErrorLevel) {
		ErrorLevel := ERROR_READ_MEMORY
		return -1
    }

	; 0x152, offset for first msg
	; 0xFC, size of a msg
	; 99, max msg
	writeString(hGTA, dwAddress + 0x152 + ( (99-line) * 0xFC), msg)
	if(ErrorLevel) {
		ErrorLevel := ERROR_WRITE_MEMORY
		return -1
    }
	
	sendinput {f7 3} ; 3 - без соба, 4 - есть собейт
	
	ErrorLevel := ERROR_OK
	return True
}

getTagNameDistance() {
	if(!checkHandles())
		return -1

	dwSAMPInfo := readDWORD(hGTA, dwSAMP + SAMP_INFO_OFFSET)
	if(ErrorLevel) {
		ErrorLevel := ERROR_READ_MEMORY
		return -1
  }

	dwSAMPInfoSettings := readDWORD(hGTA, dwSAMPInfo + SAMP_INFO_SETTINGS_OFFSET)
	if(ErrorLevel) {
		ErrorLevel := ERROR_READ_MEMORY
		return -1
  }

  distance := readFloat(hGTA, dwSAMPInfoSettings + 0x27)
	if(ErrorLevel) {
		ErrorLevel := ERROR_READ_MEMORY
		return -1
  }

	ErrorLevel := ERROR_OK
	return distance
}

setTagNameDistance(status, distance) {
	if(!checkHandles())
		return -1

	status := status ? 1 : 0

	dwSAMPInfo := readDWORD(hGTA, dwSAMP + SAMP_INFO_OFFSET)
	if(ErrorLevel) {
		ErrorLevel := ERROR_READ_MEMORY
		return -1
  }

	dwSAMPInfoSettings := readDWORD(hGTA, dwSAMPInfo + SAMP_INFO_SETTINGS_OFFSET)
	if(ErrorLevel) {
		ErrorLevel := ERROR_READ_MEMORY
		return -1
  }

	writeByte(hGTA, dwSAMPInfoSettings + 0x38, 1)
	if(ErrorLevel) {
		ErrorLevel := ERROR_WRITE_MEMORY
		return -1
  }

	writeByte(hGTA, dwSAMPInfoSettings + 0x2F, status)
	if(ErrorLevel) {
		ErrorLevel := ERROR_WRITE_MEMORY
		return -1
  }

	writeFloat(hGTA, dwSAMPInfoSettings + 0x27, distance)
	if(ErrorLevel) {
		ErrorLevel := ERROR_WRITE_MEMORY
		return -1
  }

	ErrorLevel := ERROR_OK
	return
}

; sets the ingame hour (day/night)
setTime(hour)
{
	if(!checkHandles())
		return
	; disable gta setTime function
	VarSetCapacity(nop, 6, 0)
	Loop 6 {
		NumPut(0x90, nop, A_INDEX-1, "UChar")
	}
	writeRaw(hGTA, 0x52D168, &nop, 6)

	; set our own weather
	VarSetCapacity(time, 1, 0)
	NumPut(hour, time, 0, "Int")
	writeRaw(hGTA, 0xB70153, &time, 1)
}

; sets the weather
; @param weather id
setWeather(id)
{
	if(!checkHandles())
		return
	VarSetCapacity(weather, 1, 0)
	NumPut(id, weather, 0, "Int")
	writeRaw(hGTA, 0xC81320, &weather, 1)
	if(ErrorLevel)
		return false


	return true
}

; get the id of your skin
getSkinID() {
	if(!checkHandles())
		return -1

	dwAddress := readDWORD(hGTA, 0xB6F3B8)

	if(ErrorLevel || dwAddress==0) {
		ErrorLevel := ERROR_READ_MEMORY
		return -1
	}

	id := readMem(hGTA, dwAddress + 0x22, 2, "UShort")
	if(ErrorLevel) {
		ErrorLevel := ERROR_READ_MEMORY
		return -1
	}
	ErrorLevel := ERROR_OK
	return id
}

; get the title of dialog
getDialogTitle()
{
	if(!checkHandles())
		return ""
	dwAddress := readDWORD(hGTA, dwSAMP + 0x21A0B8)
	if(ErrorLevel) {
		ErrorLevel := ERROR_READ_MEMORY
		return ""
	}
	text := readString(hGTA, dwAddress + 0x40, 128)
	if(ErrorLevel) {
		ErrorLevel := ERROR_READ_MEMORY
		return ""
	}

	ErrorLevel := ERROR_OK
	return text
}
; get the color of player
; @author democrazy
getPlayerColor(id)
{
    id += 0

    if(!checkHandles())
        return -1

    color := readDWORD(hGTA, dwSAMP + 0x216378 + 4*id)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    return color
}

; set the color of player
; @author democrazy
setPlayerColor(id,color)
{
    id += 0
    color +=0

    if(!checkHandles())
        return

    VarSetCapacity(bla, 4, 0)
    NumPut(color,bla,0,"UInt")

    writeRaw(hGTA, dwSAMP + 0x216378 + 4*id, &bla, 4)
}
; convert color from decimal into hex
; @author democrazy
colorToStr(color)
{
    color += 0
    color >>= 8
    color &= 0xffffff
    SetFormat, IntegerFast, hex
    color += 0
    color .= ""
    StringTrimLeft, color, color, 2
    SetFormat, IntegerFast, d
    if (StrLen(color) == 5)
       color := "0"color
    return "{" color "}"
}

; Get Interior param.
;;@autor Godarck

GetInterior()
{
    dwAddress := readDWORD(hGTA, ADDR_SET_INTERIOR_OFFSET)
    if (ErrorLevel || dwAddress == 0) {
        ErrorLevel := ERROR_READ_MEMORY
        return false
    }    
  return true
}

; get current weapon id
; @author AnalFatal
getWeaponId()
{
    If(!checkHandles())
    return 0

   c := readDWORD(hGTA, ADDR_CPED_PTR)
   If(ErrorLevel) {
   		ErrorLevel := ERROR_READ_MEMORY
   		return 0
   }
   id := readMem(hGTA, c + 0x740)
   If(ErrorLevel) {
   		ErrorLevel := ERROR_READ_MEMORY
   		return 0
   }

   return id
}
writeFloat(hProcess, dwAddress, wFloat) {
    if(!hProcess) {
        ErrorLevel := ERROR_INVALID_HANDLE
        return false
    }

    wFloat := FloatToHex(wFloat)

    dwRet := DllCall(   "WriteProcessMemory"
                        , "UInt", hProcess
                        , "UInt", dwAddress
                        , "UInt *", wFloat
                        , "UInt", 4
                        , "UInt *", 0)

    ErrorLevel := ERROR_OK
    return true
}

writeByte(hProcess, dwAddress, wInt) {
  if(!hProcess) {
      ErrorLevel := ERROR_INVALID_HANDLE
      return false
  }

  wInt := IntToHex(wInt)

	dwRet := DllCall(     "WriteProcessMemory"
	                      , "UInt", hProcess
	                      , "UInt", dwAddress
	                      , "UInt *", wInt
	                      , "UInt", 1
	                      , "UInt *", 0)
}

FloatToHex(value) {
   format := A_FormatInteger
   SetFormat, Integer, H
   result := DllCall("MulDiv", Float, value, Int, 1, Int, 1, UInt)
   SetFormat, Integer, %format%
   return, result
}

IntToHex(int)
{
	CurrentFormat := A_FormatInteger
	SetFormat, integer, hex
	int += 0
	SetFormat, integer, %CurrentFormat%
	return int
}

disconnectEx() {
	
	if(!checkHandles())
		return 0
	
	dwAddress := readDWORD(hGTA, dwSAMP + SAMP_INFO_OFFSET)			;g_SAMP
	if(ErrorLevel || dwAddress==0) {
		ErrorLevel := ERROR_READ_MEMORY
		return 0
	}
	
	dwAddress := readDWORD(hGTA, dwAddress + 0x3c9)			;pRakClientInterface
	if(ErrorLevel || dwAddress==0) {
		ErrorLevel := ERROR_READ_MEMORY
		return 0
	}
    
    ecx := dwAddress        ;this
	
	dwAddress := readDWORD(hGTA, dwAddress)         ;vtable
	if(ErrorLevel || dwAddress==0) {
		ErrorLevel := ERROR_READ_MEMORY
		return 0
	}
	
	
	
	VarSetCapacity(injectData, 24, 0) ;mov, call, retn
	
    NumPut(0xB9, injectData, 0, "UChar")	;mov ecx 	0+1
	NumPut(ecx, injectData, 1, "UInt")			;1+4
    
	NumPut(0xB8, injectData, 5, "UChar")	;mov eax 	5+1
	NumPut(dwAddress, injectData, 6, "UInt")			;6+4
	
	;NumPut(0x006A006A, injectData, 10, "UInt")  ; 2x push			10+4
    
    NumPut(0x68, injectData, 10, "UChar")		;10 + 1		;push style
	NumPut(0, injectData, 11, "UInt")		;11 + 4
    
    NumPut(0x68, injectData, 15, "UChar")		;15 + 1		;push style
	NumPut(500, injectData, 16, "UInt")		;16 + 4
    
    ;---
	
	NumPut(0x50FF, injectData, 20, "UShort")			;20 + 2
	NumPut(0x08, injectData, 22, "UChar")			;22 + 1
	
	NumPut(0xC3, injectData, 23, "UChar")	;retn		23+1
	
	writeRaw(hGTA, pInjectFunc, &injectData, 24)
	if(ErrorLevel)
		return false
	
	hThread := createRemoteThread(hGTA, 0, 0, pInjectFunc, 0, 0, 0)
	if(ErrorLevel)
		return false
	
	waitForSingleObject(hThread, 0xFFFFFFFF)

  closeProcess(hThread)

	return true
}
setrestart()
{
  VarSetCapacity(old, 4, 0)
  dwAddress := readDWORD(hGTA, dwSAMP + SAMP_INFO_OFFSET)			;g_SAMP
    if(ErrorLevel || dwAddress==0) {
      ErrorLevel := ERROR_READ_MEMORY
      return 0
  }

  NumPut(9,old,0,"Int")
  writeRaw(hGTA, dwAddress + 957, &old, 4)
}
restartGameEx() {
	
	if(!checkHandles())
		return -1
	
	dwAddress := readDWORD(hGTA, dwSAMP + SAMP_INFO_OFFSET)			;g_SAMP
	if(ErrorLevel || dwAddress==0) {
		ErrorLevel := ERROR_READ_MEMORY
		return -1
	}
	
	dwFunc := dwSAMP + 0xA060
	
	VarSetCapacity(injectData, 11, 0) ;mov, call, retn
	
	NumPut(0xB9, injectData, 0, "UChar")	;mov ecx 	0+1
	NumPut(dwAddress, injectData, 1, "UInt")			;1+4
	NumPut(0xE8, injectData, 5, "UChar")	;call 		5+1
	offset := dwFunc - (pInjectFunc + 10)
	NumPut(offset, injectData, 6, "Int")	;			6+4
    NumPut(0xC3, injectData, 10, "UChar")	;		10+1
	
	writeRaw(hGTA, pInjectFunc, &injectData, 11)
	if(ErrorLevel)
		return false

	hThread := createRemoteThread(hGTA, 0, 0, pInjectFunc, 0, 0, 0)
	if(ErrorLevel)
		return false

	waitForSingleObject(hThread, 0xFFFFFFFF)

  closeProcess(hThread)

	return true
}
; ##### SAMP-Funktionen #####

isPlayerInStreamById(player_id, radius := 150)
{
	NAME := ""
	check := []
	p := getStreamedInPlayersInfo()
	if (!p)
		return 0
	For i, o in p ; берет игроков из стрима в переменную NAME
	{
		if (Floor(getDist(getCoordinates(), o.POS)) <= radius)
		{
			NAME .= o.NAME ", "
		}
	}
	if (IsObject(player_id)) ; Если получен массив
	{
		for k, v in player_id ; Проверяет находиться ли ид из массива в зоне стрима
		{
			i := 0
			Loop, Parse, % NAME, % ",", % " ,.`n`r"
			{
				if (A_LoopField == getPlayerNameById(v))
				{
					i := 1
					break
				}
			}
			if (i)
				check[v] := i
			else
				check[v] := i
		}
		return check
	}
	else if (!IsObject(player_id)) ; если передан ид
	{
		
		if (!getPlayerNameById(player_id))
			return 0
		i := 0
		Loop, Parse, % NAME, % ",", % " ,.`n`r"
		{
			if (A_LoopField == getPlayerNameById(player_id))
				return 1
		}
		return 0
	}
}


IsSAMPAvailable() {
    if(!checkHandles())
        return false
	
	dwChatInfo := readDWORD(hGTA, dwSAMP + ADDR_SAMP_CHATMSG_PTR)
	
	if(dwChatInfo == 0 || dwChatInfo == "ERROR")
	{
		return false
	}
	else
	{
		return true
	}
}
isInChat() {
    if(!checkHandles())
        return -1
    
    dwPtr := dwSAMP + ADDR_SAMP_INCHAT_PTR
    dwAddress := readDWORD(hGTA, dwPtr) + ADDR_SAMP_INCHAT_PTR_OFF
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    dwInChat := readDWORD(hGTA, dwAddress)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    ErrorLevel := ERROR_OK
    if(dwInChat > 0) {
        return true
    } else {
        return false
    }
}

getUsername() {
    if(!checkHandles())
        return ""
    
    dwAddress := dwSAMP + ADDR_SAMP_USERNAME
    sUsername := readString(hGTA, dwAddress, 25)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return ""
    }
    
    ErrorLevel := ERROR_OK
    return sUsername
}

getId() {
    s:=getUsername()
    return getPlayerIdByName(s)
}


SendChat(wText) {
     wText := "" wText
    
    if(!checkHandles())
        return false
    
    dwFunc:=0
    if(SubStr(wText, 1, 1) == "/") {
        dwFunc := dwSAMP + FUNC_SAMP_SENDCMD
    } else {
        dwFunc := dwSAMP + FUNC_SAMP_SENDSAY
    }
    
    callWithParams(hGTA, dwFunc, [["s", wText]], false)
    
    ErrorLevel := ERROR_OK
    return true
}
;=================================================[Работа с памятью]=========================================================
; Источник - http://dumpz.org/2345353/
ProcessReadMemory(address, processIDorName, type := "Int", numBytes := 4) {
    VarSetCapacity(buf, numBytes, 0)
    Process Exist, %processIDorName%
    if !processID := ErrorLevel
        return -1
        ;throw Exception("Invalid process name or process ID:`n`n""" . processIDorName . """")
    if !processHandle := DllCall("OpenProcess", "Int", 24, "UInt", 0, "UInt", processID, "Ptr")
        throw Exception("Failed to open process.`n`nError code:`t" . A_LastError)
    result := DllCall("ReadProcessMemory", "Ptr", processHandle, "Ptr", address, "Ptr", &buf, "Ptr", numBytes, "PtrP", numBytesRead, "UInt")
    if !DllCall("CloseHandle", "Ptr", processHandle, "UInt") && !result
        throw Exception("Failed to close process handle.`n`nError code:`t" . A_LastError)
    if !result
        throw Exception("Failed to read process memory.`n`nError code:`t" . A_LastError)
    if !numBytesRead
        throw Exception("Read 0 bytes from the`n`nprocess:`t" . processIDorName . "`naddress:`t" . address)
    return (type = "Str")
        ? StrGet(&buf, numBytes)
        : NumGet(buf, type)
}
ProcessWriteMemory(data, address, processIDorName, type := "Int", numBytes := 4) {
    VarSetCapacity(buf, numBytes, 0)
    (type = "Str")
        ? StrPut(data, &buf, numBytes)
        : NumPut(data, buf, type)
    Process Exist, %processIDorName%
    if !processID := ErrorLevel
        ;throw Exception("Invalid process name or process ID:`n`n""" . processIDorName . """")
        return
    if !processHandle := DllCall("OpenProcess", "Int", 40, "UInt", 0, "UInt", processID, "Ptr")
        throw Exception("Failed to open process.`n`nError code:`t" . A_LastError)
        result := DllCall("WriteProcessMemory", "Ptr", processHandle, "Ptr", address, "Ptr", &buf, "Ptr", numBytes, "UInt", 0, "UInt")
    if !DllCall("CloseHandle", "Ptr", processHandle, "UInt") && !result
        throw Exception("Failed to close process handle.`n`nError code:`t" . A_LastError)
    if !result
        ;throw Exception("Failed to write process memory.`n`nError code:`t" . A_LastError)
        return
    return result
}
;==================================================[Работа с памятью]==========================================================
addChatMessage(wText) {
    wText := "" wText

    if(!checkHandles())
        return false
    
    dwFunc := dwSAMP + FUNC_SAMP_ADDTOCHATWND
    dwChatInfo := readDWORD(hGTA, dwSAMP + ADDR_SAMP_CHATMSG_PTR)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return false
    }
    
    callWithParams(hGTA, dwFunc, [["p", dwChatInfo], ["s", wText]], true)
    
    ErrorLevel := ERROR_OK
    return true
}

showGameText(wText, dwTime, dwSize) {
    wText := "" wText
    dwTime += 0
    dwTime := Floor(dwTime)
    dwSize += 0
    dwSize := Floor(dwSize)

    if(!checkHandles())
        return false
    
    dwFunc := dwSAMP + FUNC_SAMP_SHOWGAMETEXT
    
    callWithParams(hGTA, dwFunc, [["s", wText], ["i", dwTime], ["i", dwSize]], false)
    
    ErrorLevel := ERROR_OK
    return true
}

playAudioStream(wUrl) {
    wUrl := "" wUrl
    
    if(!checkHandles())
        return false
    
    dwFunc := dwSAMP + FUNC_SAMP_PLAYAUDIOSTR
    
    patchRadio()
    
    callWithParams(hGTA, dwFunc, [["s", wUrl], ["i", 0], ["i", 0], ["i", 0], ["i", 0], ["i", 0]], false)
    
    unPatchRadio()
    
    ErrorLevel := ERROR_OK
    return true
}

stopAudioStream() {
    if(!checkHandles())
        return false
    
    dwFunc := dwSAMP + FUNC_SAMP_STOPAUDIOSTR
    
    patchRadio()
    
    callWithParams(hGTA, dwFunc, [["i", 1]], false)
    
    unPatchRadio()
    
    ErrorLevel := ERROR_OK
    return true
}

patchRadio()
{
    if(!checkHandles())
        return false
    
    VarSetCapacity(nop, 4, 0)
    NumPut(0x90909090,nop,0,"UInt")
    
    dwFunc := dwSAMP + FUNC_SAMP_PLAYAUDIOSTR
    writeRaw(hGTA, dwFunc, &nop, 4)
    writeRaw(hGTA, dwFunc+4, &nop, 1)
    
    dwFunc := dwSAMP + FUNC_SAMP_STOPAUDIOSTR
    writeRaw(hGTA, dwFunc, &nop, 4)
    writeRaw(hGTA, dwFunc+4, &nop, 1)
    return true
}

unPatchRadio()
{
    if(!checkHandles())
        return false
    
    VarSetCapacity(old, 4, 0)
    
    dwFunc := dwSAMP + FUNC_SAMP_PLAYAUDIOSTR
    NumPut(0x74003980,old,0,"UInt")
    writeRaw(hGTA, dwFunc, &old, 4)
    NumPut(0x39,old,0,"UChar")
    writeRaw(hGTA, dwFunc+4, &old, 1)
    
    dwFunc := dwSAMP + FUNC_SAMP_STOPAUDIOSTR
    NumPut(0x74003980,old,0,"UInt")
    writeRaw(hGTA, dwFunc, &old, 4)
    NumPut(0x09,old,0,"UChar")
    writeRaw(hGTA, dwFunc+4, &old, 1)
    return true
}

blockChatInput() {
    if(!checkHandles())
        return false
    
    VarSetCapacity(nop, 2, 0)
    
    dwFunc := dwSAMP + FUNC_SAMP_SENDSAY
    NumPut(0x04C2,nop,0,"Short")
    writeRaw(hGTA, dwFunc, &nop, 2)
    
    dwFunc := dwSAMP + FUNC_SAMP_SENDCMD
    writeRaw(hGTA, dwFunc, &nop, 2)
    
    return true
}

unBlockChatInput() {
    if(!checkHandles())
        return false
    
    VarSetCapacity(nop, 2, 0)
    
    dwFunc := dwSAMP + FUNC_SAMP_SENDSAY
    NumPut(0xA164,nop,0,"Short")
    writeRaw(hGTA, dwFunc, &nop, 2)
    
    dwFunc := dwSAMP + FUNC_SAMP_SENDCMD
    writeRaw(hGTA, dwFunc, &nop, 2)
    
    return true
}

getServerName() {
    if(!checkHandles())
        return -1
    
    dwAdress := readMem(hGTA, dwSAMP + 0x21A0F8, 4, "int")
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    if(!dwAdress)
        return -1
    
    ServerName := readString(hGTA, dwAdress + 0x121, 200)
    
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    ErrorLevel := ERROR_OK
    return ServerName
}

getServerIP() {
    if(!checkHandles())
        return -1
    
    dwAdress := readMem(hGTA, dwSAMP + 0x21A0F8, 4, "int")
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    if(!dwAdress)
        return -1
    
    ServerIP := readString(hGTA, dwAdress + 0x20, 100)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    ErrorLevel := ERROR_OK
    return ServerIP
}

getServerPort() {
    if(!checkHandles())
        return -1
    
    dwAdress := readMem(hGTA, dwSAMP + 0x21A0F8, 4, "int")
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    if(!dwAdress)
        return -1
    
    ServerPort := readMem(hGTA, dwAdress + 0x225, 4, "int")
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    ErrorLevel := ERROR_OK
    return ServerPort
}

getWeatherID() {
    if(!checkHandles())
        return -1
    
    dwGTA := getModuleBaseAddress("gta_sa.exe", hGTA)
    WeatherID := readMem(hGTA, dwGTA + 0xC81320, 2, "byte")
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    ErrorLevel := ERROR_OK    
    return WeatherID
}

getWeatherName() {
    if(isPlayerInAnyVehicle() == 0)
        return -1
    
    if(id >= 0 && id < 23)
    {
        return oweatherNames[id-1]
    }
    return ""
}

; ##### Extra-Player-Funktionen #####
; by Godarck
isTargetDriverbyId(dwId) 
{ 
    if(!checkHandles()) 
    return -1 
    dwPedPointer := getPedById(dwId) 
    dwAddrVPtr := getVehiclePointerByPed(dwPedPointer) 
    if(ErrorLevel) { 
    ErrorLevel := ERROR_READ_MEMORY 
    return -1 
    } 
    dwVal := readDWORD(hGTA, dwAddrVPtr + ADDR_VEHICLE_DRIVER) 
    if(ErrorLevel) { 
    ErrorLevel := ERROR_READ_MEMORY 
    return -1 
    } 
    ErrorLevel := ERROR_OK 
    return (dwVal == dwPedPointer) 
}
getTargetPed() {
	if(!checkHandles())
        return 0
	
	dwAddress := readDWORD(hGTA, 0xB6F3B8)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return 0
    }
	if(!dwAddress)
		return 0
		
	dwAddress := readDWORD(hGTA, dwAddress+0x79C)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return 0
    }
	
	ErrorLevel := ERROR_OK
	return dwAddress
}

calcScreenCoors(fX,fY,fZ)
{
	if(!checkHandles())
		return false
	
	dwM := 0xB6FA2C
	
	m_11 := readFloat(hGTA, dwM + 0*4)
	if(ErrorLevel) {
		ErrorLevel := ERROR_READ_MEMORY
		return false
	}
	
	m_12 := readFloat(hGTA, dwM + 1*4)
	m_13 := readFloat(hGTA, dwM + 2*4)
	m_21 := readFloat(hGTA, dwM + 4*4)
	m_22 := readFloat(hGTA, dwM + 5*4)
	m_23 := readFloat(hGTA, dwM + 6*4)
	m_31 := readFloat(hGTA, dwM + 8*4)
	m_32 := readFloat(hGTA, dwM + 9*4)
	m_33 := readFloat(hGTA, dwM + 10*4)
	m_41 := readFloat(hGTA, dwM + 12*4)
	m_42 := readFloat(hGTA, dwM + 13*4)
	m_43 := readFloat(hGTA, dwM + 14*4)
	
	dwLenX := readDWORD(hGTA, 0xC17044)
	if(ErrorLevel) {
		ErrorLevel := ERROR_READ_MEMORY
		return false
	}
	dwLenY := readDWORD(hGTA, 0xC17048)
	
	frX := fZ * m_31 + fY * m_21 + fX * m_11 + m_41
	frY := fZ * m_32 + fY * m_22 + fX * m_12 + m_42
	frZ := fZ * m_33 + fY * m_23 + fX * m_13 + m_43
	
	fRecip := 1.0/frZ
	frX *= fRecip * dwLenX
	frY *= fRecip * dwLenY
    
    if(frX<=dwLenX && frY<=dwLenY && frZ>1)
        return [frX,frY,frZ]
}
ConvertCarColor(Color)
{
    ArrayRGB := ["0xF5F5F5FF", "0x2A77A1FF", "0x840410FF", "0x263739FF", "0x86446EFF", "0xD78E10FF", "0x4C75B7FF", "0xBDBEC6FF", "0x5E7072FF", "0x46597AFF", "0x656A79FF", "0x5D7E8DFF", "0x58595AFF", "0xD6DAD6FF", "0x9CA1A3FF", "0x335F3FFF", "0x730E1AFF", "0x7B0A2AFF", "0x9F9D94FF", "0x3B4E78FF", "0x732E3EFF", "0x691E3BFF", "0x96918CFF", "0x515459FF", "0x3F3E45FF", "0xA5A9A7FF", "0x635C5AFF", "0x3D4A68FF", "0x979592FF", "0x421F21FF", "0x5F272BFF", "0x8494ABFF", "0x767B7CFF", "0x646464FF", "0x5A5752FF", "0x252527FF", "0x2D3A35FF", "0x93A396FF", "0x6D7A88FF", "0x221918FF", "0x6F675FFF", "0x7C1C2AFF", "0x5F0A15FF", "0x193826FF", "0x5D1B20FF", "0x9D9872FF", "0x7A7560FF", "0x989586FF", "0xADB0B0FF", "0x848988FF", "0x304F45FF", "0x4D6268FF", "0x162248FF", "0x272F4BFF", "0x7D6256FF", "0x9EA4ABFF", "0x9C8D71FF", "0x6D1822FF", "0x4E6881FF", "0x9C9C98FF", "0x917347FF", "0x661C26FF", "0x949D9FFF", "0xA4A7A5FF", "0x8E8C46FF", "0x341A1EFF", "0x6A7A8CFF", "0xAAAD8EFF", "0xAB988FFF", "0x851F2EFF", "0x6F8297FF", "0x585853FF", "0x9AA790FF", "0x601A23FF", "0x20202CFF", "0xA4A096FF", "0xAA9D84FF", "0x78222BFF", "0x0E316DFF", "0x722A3FFF", "0x7B715EFF", "0x741D28FF", "0x1E2E32FF", "0x4D322FFF", "0x7C1B44FF", "0x2E5B20FF", "0x395A83FF", "0x6D2837FF", "0xA7A28FFF", "0xAFB1B1FF", "0x364155FF", "0x6D6C6EFF", "0x0F6A89FF", "0x204B6BFF", "0x2B3E57FF", "0x9B9F9DFF", "0x6C8495FF", "0x4D8495FF", "0xAE9B7FFF", "0x406C8FFF", "0x1F253BFF", "0xAB9276FF", "0x134573FF", "0x96816CFF", "0x64686AFF", "0x105082FF", "0xA19983FF", "0x385694FF", "0x525661FF", "0x7F6956FF", "0x8C929AFF", "0x596E87FF", "0x473532FF", "0x44624FFF", "0x730A27FF", "0x223457FF", "0x640D1BFF", "0xA3ADC6FF", "0x695853FF", "0x9B8B80FF", "0x620B1CFF", "0x5B5D5EFF", "0x624428FF", "0x731827FF", "0x1B376DFF", "0xEC6AAEFF", "0x000000FF"]
    ArrayRGBNew := ["0x177517FF", "0x210606FF", "0x125478FF", "0x452A0DFF", "0x571E1EFF", "0x010701FF", "0x25225AFF", "0x2C89AAFF", "0x8A4DBDFF", "0x35963AFF", "0xB7B7B7FF", "0x464C8DFF", "0x84888CFF", "0x817867FF", "0x817A26FF", "0x6A506FFF", "0x583E6FFF", "0x8CB972FF", "0x824F78FF", "0x6D276AFF", "0x1E1D13FF", "0x1E1306FF", "0x1F2518FF", "0x2C4531FF", "0x1E4C99FF", "0x2E5F43FF", "0x1E9948FF", "0x1E9999FF", "0x999976FF", "0x7C8499FF", "0x992E1EFF", "0x2C1E08FF", "0x142407FF", "0x993E4DFF", "0x1E4C99FF", "0x198181FF", "0x1A292AFF", "0x16616FFF", "0x1B6687FF", "0x6C3F99FF", "0x481A0EFF", "0x7A7399FF", "0x746D99FF", "0x53387EFF", "0x222407FF", "0x3E190CFF", "0x46210EFF", "0x991E1EFF", "0x8D4C8DFF", "0x805B80FF", "0x7B3E7EFF", "0x3C1737FF", "0x733517FF", "0x781818FF", "0x83341AFF", "0x8E2F1CFF", "0x7E3E53FF", "0x7C6D7CFF", "0x020C02FF", "0x072407FF", "0x163012FF", "0x16301BFF", "0x642B4FFF", "0x368452FF", "0x999590FF", "0x818D96FF", "0x99991EFF", "0x7F994CFF", "0x839292FF", "0x788222FF", "0x2B3C99FF", "0x3A3A0BFF", "0x8A794EFF", "0x0E1F49FF", "0x15371CFF", "0x15273AFF", "0x375775FF", "0x060820FF", "0x071326FF", "0x20394BFF", "0x2C5089FF", "0x15426CFF", "0x103250FF", "0x241663FF", "0x692015FF", "0x8C8D94FF", "0x516013FF", "0x090F02FF", "0x8C573AFF", "0x52888EFF", "0x995C52FF", "0x99581EFF", "0x993A63FF", "0x998F4EFF", "0x99311EFF", "0x0D1842FF", "0x521E1EFF", "0x42420DFF", "0x4C991EFF", "0x082A1DFF", "0x96821DFF", "0x197F19FF", "0x3B141FFF", "0x745217FF", "0x893F8DFF", "0x7E1A6CFF", "0x0B370BFF", "0x27450DFF", "0x071F24FF", "0x784573FF", "0x8A653AFF", "0x732617FF", "0x319490FF", "0x56941DFF", "0x59163DFF", "0x1B8A2FFF", "0x38160BFF", "0x041804FF", "0x355D8EFF", "0x2E3F5BFF", "0x561A28FF", "0x4E0E27FF", "0x706C67FF", "0x3B3E42FF", "0x2E2D33FF", "0x7B7E7DFF", "0x4A4442FF", "0x28344EFF"]
if (Color > 0) and (Color < 128)
  RGB := ArrayRGB[Color]
if (Color > 127) and (Color < 256)
{
  RGB := ArrayRGBNew[Color + 127]
}
StringLeft, RGBTemp, RGB, 8
StringRight, RGB, RGBTemp, 6
if Color = 0
   RGB := "000000"
return RGB
}
;--
getPedById(dwId) {
    dwId += 0
    dwId := Floor(dwId)
    if(dwId < 0 || dwId >= SAMP_PLAYER_MAX)
        return 0
    
    if(iRefreshScoreboard+iUpdateTick > A_TickCount)
    {
        if(oScoreboardData[dwId])
        {
            if(oScoreboardData[dwId].HasKey("PED"))
                return oScoreboardData[dwId].PED
        }
        return 0
    }
    
    if(!updateOScoreboardData())
        return 0
    
    if(oScoreboardData[dwId])
    {
        if(oScoreboardData[dwId].HasKey("PED"))
            return oScoreboardData[dwId].PED
    }
    return 0
}

getIdByPed(dwPed) {
    dwPed += 0
    dwPed := Floor(dwPed)
	if(!dwPed)
		return -1
	
	if(iRefreshScoreboard+iUpdateTick > A_TickCount)
    {
		For i, o in oScoreboardData
        {
            if(o.HasKey("PED"))
            {
				if(o.PED==dwPed)
					return i
            }
        }
        return -1
    }
    
    if(!updateOScoreboardData())
        return -1
    
	For i, o in oScoreboardData
    {
        if(o.HasKey("PED"))
        {
			if(o.PED==dwPed)
				return i
        }
    }
    return -1
}
IsInAFK() {
    res := ProcessReadMemory(0xBA6748 + 0x5C, "gta_sa.exe")
    if (res==-1)
        return -1
    WinGet, win, MinMax, GTA:SA:MP
    if ((res=0) and (win=-1)) or res=1
        return 1
    return 0
}
getStreamedInPlayersInfo() {
    r:=[]
    if(iRefreshScoreboard+iUpdateTick > A_TickCount)
    {
        For i, o in oScoreboardData
        {
            if(o.HasKey("PED"))
            {
                p := getPedCoordinates(o.PED)
                if(p)
                {
                    o.POS := p
                    r[i] := o
                }
            }
        }
        return r
    }
    
    if(!updateOScoreboardData())
        return ""
    
    For i, o in oScoreboardData
    {
        if(o.HasKey("PED"))
        {
            p := getPedCoordinates(o.PED)
            if(p)
            {
                o.POS := p
                r[i] := o
            }
        }
    }
    return r
}

callFuncForAllStreamedInPlayers(cfunc,dist=0x7fffffff) {
    cfunc := "" cfunc
    dist += 0
    if(!IsFunc(cfunc))
        return false
    p := getStreamedInPlayersInfo()
    if(!p)
        return false
    if(dist<0x7fffffff)
    {
        lpos := getCoordinates()
        if(!lpos)
            return false
        For i, o in p
        {
            if(dist>getDist(lpos,o.POS))
                %cfunc%(o)
        }
    }
    else
    {
        For i, o in p
            %cfunc%(o)
    }
    return true
}

getDist(pos1,pos2) {
	if(!pos1 || !pos2)
		return 0
    return Sqrt((pos1[1]-pos2[1])*(pos1[1]-pos2[1])+(pos1[2]-pos2[2])*(pos1[2]-pos2[2])+(pos1[3]-pos2[3])*(pos1[3]-pos2[3]))
}
getClosestPlayerPed() {
    dist := 0x7fffffff              ;max int32
    p := getStreamedInPlayersInfo()
	if(!p)
		return -1
    lpos := getCoordinates()
    if(!lpos)
        return -1
	id := -1
    For i, o in p
    {
        t:=getDist(lpos,o.POS)
        if(t<dist)
        {
            dist := t
            id := i
        }
    }
    PED := getPedById(id)
    return PED
}

getClosestPlayerId() {
    dist := 0x7fffffff              ;max int32
    p := getStreamedInPlayersInfo()
	if(!p)
		return -1
    lpos := getCoordinates()
    if(!lpos)
        return -1
	id := -1
    For i, o in p
    {
        t:=getDist(lpos,o.POS)
        if(t<dist)
        {
            dist := t
            id := i
        }
    }
    return id
}

CountOnlinePlayers() {
if(!checkHandles())
return -1
dwOnline := readDWORD(hGTA, dwSAMP + 0x21A0B4)
if(ErrorLevel) {
ErrorLevel := ERROR_READ_MEMORY
return -1
}
dwAddr := dwOnline + 0x4
OnlinePlayers := readDWORD(hGTA, dwAddr)
if(ErrorLevel) {
ErrorLevel := ERROR_READ_MEMORY
return -1
}
ErrorLevel := ERROR_OK
return OnlinePlayers
}

getPedCoordinates(dwPED) {
    dwPED += 0
    dwPED := Floor(dwPED)
    if(!dwPED)
        return ""
    
    if(!checkHandles())
        return ""

    dwAddress := readDWORD(hGTA, dwPED + 0x14)
    if(ErrorLevel || dwAddress==0) {
        ErrorLevel := ERROR_READ_MEMORY
        return ""
    }
    
    fX := readFloat(hGTA, dwAddress + 0x30)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return ""
    }
    
    fY := readFloat(hGTA, dwAddress + 0x34)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return ""
    }
    
    fZ := readFloat(hGTA, dwAddress + 0x38)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return ""
    }
    
    ErrorLevel := ERROR_OK
    return [fX, fY, fZ]
}

getTargetPos(dwId) {
    dwId += 0
    dwId := Floor(dwId)
    if(dwId < 0 || dwId >= SAMP_PLAYER_MAX)
        return ""
    
    if(iRefreshScoreboard+iUpdateTick > A_TickCount)
    {
        if(oScoreboardData[dwId])
        {
			if(oScoreboardData[dwId].HasKey("PED"))
				return getPedCoordinates(oScoreboardData[dwId].PED)
			if(oScoreboardData[dwId].HasKey("MPOS"))
				return oScoreboardData[dwId].MPOS
		}
        return ""
    }
    
    if(!updateOScoreboardData())
        return ""
    
    if(oScoreboardData[dwId])
    {
		if(oScoreboardData[dwId].HasKey("PED"))
			return getPedCoordinates(oScoreboardData[dwId].PED)
		if(oScoreboardData[dwId].HasKey("MPOS"))
			return oScoreboardData[dwId].MPOS
	}
    return ""
}

getTargetPlayerSkinIdByPed(dwPED) {
    if(!checkHandles())
        return -1
    
    dwAddr := dwPED + ADDR_CPED_SKINIDOFF
    SkinID := readMem(hGTA, dwAddr, 2, "byte")
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    ErrorLevel := ERROR_OK
    return SkinID
}

getTargetPlayerSkinIdById(dwId) {
    if(!checkHandles())
        return -1
    
    dwPED := getPedById(dwId)
    dwAddr := dwPED + ADDR_CPED_SKINIDOFF
    
    SkinID := readMem(hGTA, dwAddr, 2, "byte")
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    ErrorLevel := ERROR_OK
    return SkinID
}

; ##### Extra-Player-Fahrzeug-Funktionenn #####

NearPlayerInCar(dist)
{
    TempDist := 100000
    if(!p := getStreamedInPlayersInfo())
        return false
    if(!lpos := getCoordinates())
        return false
    for i, o in p
    {
        t := getDist(lpos, o.POS)
        if(t <= dist)
        {
            if(t < TempDist && t > 5 && isTargetInAnyVehiclebyId(o.ID))
                TempId := i, TempDist := t
        }
    }
    return TempId
}

getVehiclePointerByPed(dwPED) {
    dwPED += 0
    dwPED := Floor(dwPED)
    if(!dwPED)
        return 0
	if(!checkHandles())
        return 0
	dwAddress := readDWORD(hGTA, dwPED + 0x58C)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return 0
    }
	ErrorLevel := ERROR_OK
	return dwAddress
}

getVehiclePointerById(dwId) {
    if(!dwId)
        return 0
	if(!checkHandles())
        return 0
    
    dwPed_By_Id := getPedById(dwId)
    
	dwAddress := readDWORD(hGTA, dwPed_By_Id + 0x58C)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return 0
    }
	ErrorLevel := ERROR_OK
	return dwAddress
}

isTargetInAnyVehicleByPed(dwPED)
{
    if(!checkHandles())
        return -1
    
    dwVehiclePointer := getVehiclePointerByPed(dwPedPointer)
    
    if(dwVehiclePointer > 0)
    {
        return 1
    }
    else if(dwVehiclePointer <= 0)
    {
        return 0
    }
    else
    {
        return -1
    }
}

isTargetInAnyVehiclebyId(dwId)
{
    if(!checkHandles())
        return -1
    
    dwPedPointer := getPedById(dwId)
    dwVehiclePointer := getVehiclePointerByPed(dwPedPointer)
    
    if(dwVehiclePointer > 0)
    {
        return 1
    }
    else if(dwVehiclePointer <= 0)
    {
        return 0
    }
    else
    {
        return -1
    }
}

getTargetVehicleHealthByPed(dwPed) {
    if(!checkHandles())
        return -1
    
    dwVehPtr := getVehiclePointerByPed(dwPed)    
    dwAddr := dwVehPtr + ADDR_VEHICLE_HPOFF
    fHealth := readFloat(hGTA, dwAddr)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    ErrorLevel := ERROR_OK
    return Round(fHealth)
}

getTargetVehicleHealthById(dwId) {
    if(!checkHandles())
        return -1
    
    dwVehPtr := getVehiclePointerById(dwId)    
    dwAddr := dwVehPtr + ADDR_VEHICLE_HPOFF
    fHealth := readFloat(hGTA, dwAddr)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    ErrorLevel := ERROR_OK
    return Round(fHealth)
}

getTargetVehicleTypeByPed(dwPED) {
    if(!checkHandles())
        return 0
    
    dwAddr := getVehiclePointerByPed(dwPED)
    
    if(!dwAddr)
        return 0
    
    cVal := readMem(hGTA, dwAddr + ADDR_VEHICLE_TYPE, 1, "Char")
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return 0
    }
    
    ErrorLevel := ERROR_OK
    if(!cVal)
    {
        mid := getVehicleModelId()
        Loop % oAirplaneModels.MaxIndex()
        {
            if(oAirplaneModels[A_Index]==mid)
                return 5
        }
        return 1
    }
    else if(cVal==5)
        return 2
    else if(cVal==6)
        return 3
    else if(cVal==9)
    {
        mid := getVehicleModelId()
        Loop % oBikeModels.MaxIndex()
        {
            if(oBikeModels[A_Index]==mid)
                return 6
        }
        return 4
    }
    return 0
}

getTargetVehicleTypeById(dwId) {
    if(!checkHandles())
        return 0
    
    dwAddr := getVehiclePointerById(dwId)
    
    if(!dwAddr)
        return 0
    
    cVal := readMem(hGTA, dwAddr + ADDR_VEHICLE_TYPE, 1, "Char")
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return 0
    }
    
    ErrorLevel := ERROR_OK
    if(!cVal)
    {
        mid := getVehicleModelId()
        Loop % oAirplaneModels.MaxIndex()
        {
            if(oAirplaneModels[A_Index]==mid)
                return 5
        }
        return 1
    }
    else if(cVal==5)
        return 2
    else if(cVal==6)
        return 3
    else if(cVal==9)
    {
        mid := getVehicleModelId()
        Loop % oBikeModels.MaxIndex()
        {
            if(oBikeModels[A_Index]==mid)
                return 6
        }
        return 4
    }
    return 0
}

getTargetVehicleModelIdByPed(dwPED) {
    if(!checkHandles())
        return 0
    
    dwAddr := getVehiclePointerByPed(dwPED)
    
    if(!dwAddr)
        return 0
    
    sVal := readMem(hGTA, dwAddr + ADDR_VEHICLE_MODEL, 2, "Short")
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return 0
    }
    
    ErrorLevel := ERROR_OK
    return sVal
}

getTargetVehicleModelIdById(dwId) {
    if(!checkHandles())
        return 0
    
    dwAddr := getVehiclePointerById(dwId)
    
    if(!dwAddr)
        return 0
    
    sVal := readMem(hGTA, dwAddr + ADDR_VEHICLE_MODEL, 2, "Short")
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return 0
    }
    
    ErrorLevel := ERROR_OK
    return sVal
}

getTargetVehicleModelNameByPed(dwPED) {
    id := getTargetVehicleModelIdByPed(dwPED)
    if(id > 400 && id < 611)
    {
        return ovehicleNames[id-399]
    }
    return ""
}

getTargetVehicleModelNameById(dwId) {
    id := getTargetVehicleModelIdById(dwId)
    if(id > 400 && id < 611)
    {
        return ovehicleNames[id-399]
    }
    return ""
}

getTargetVehicleLightStateByPed(dwPED) {
    if(!checkHandles())
        return -1
    
    dwAddr := getVehiclePointerByPed(dwPED)
    
    if(!dwAddr)
        return -1
    
    dwVal := readMem(hGTA, dwAddr + ADDR_VEHICLE_LIGHTSTATE, 1, "byte")
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    ErrorLevel := ERROR_OK
    return (dwVal>0)
}


getTargetVehicleLightStateById(dwId) {
    if(!checkHandles())
        return -1
    
    dwAddr := getVehiclePointerById(dwId)
    
    if(!dwAddr)
        return -1
    
    dwVal := readMem(hGTA, dwAddr + ADDR_VEHICLE_LIGHTSTATE, 1, "byte")
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    ErrorLevel := ERROR_OK
    return (dwVal>0)
}

getTargetVehicleLockStateByPed(dwPED) {
    if(!checkHandles())
        return -1
    
    dwAddr := getVehiclePointerByPed(dwPED)
    
    if(!dwAddr)
        return -1
    
    dwVal := readDWORD(hGTA, dwAddr + ADDR_VEHICLE_DOORSTATE)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    ErrorLevel := ERROR_OK
    return (dwVal==2)
}

getTargetVehicleLockStateById(dwId) {
    if(!checkHandles())
        return -1
    
    dwAddr := getVehiclePointerById(dwId)
    
    if(!dwAddr)
        return -1
    
    dwVal := readDWORD(hGTA, dwAddr + ADDR_VEHICLE_DOORSTATE)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    ErrorLevel := ERROR_OK
    return (dwVal==2)
}

getTargetVehicleColor1byPed(dwPED) {
    if(!checkHandles())
        return 0
    
    dwAddr := getVehiclePointerByPed(dwPED)
    
    if(!dwAddr)
        return 0
	
    sVal := readMem(hGTA, dwAddr + 1076, 1, "byte")
	
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return 0
    }
    
    ErrorLevel := ERROR_OK
    return sVal
}

getTargetVehicleColor1byId(dwId) {
    if(!checkHandles())
        return 0
    
    dwAddr := getVehiclePointerById(dwId)
    
    if(!dwAddr)
        return 0
	
    sVal := readMem(hGTA, dwAddr + 1076, 1, "byte")
	
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return 0
    }
    
    ErrorLevel := ERROR_OK
    return sVal
}

getTargetVehicleColor2byPed(dwPED) {
    if(!checkHandles())
        return 0
    
    dwAddr := getVehiclePointerByPed(dwPED)
    
    if(!dwAddr)
        return 0
	
    sVal := readMem(hGTA, dwAddr + 1077, 1, "byte")
	
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return 0
    }
    
    ErrorLevel := ERROR_OK
    return sVal
}

getTargetVehicleColor2byId(dwId) {
    if(!checkHandles())
        return 0
    
    dwAddr := getVehiclePointerById(dwId)
    
    if(!dwAddr)
        return 0
	
    sVal := readMem(hGTA, dwAddr + 1077, 1, "byte")
	
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return 0
    }
    
    ErrorLevel := ERROR_OK
    return sVal
}

getTargetVehicleSpeedByPed(dwPED) {
    if(!checkHandles())
        return -1
 
    dwAddr := getVehiclePointerByPed(dwPED)
    
    fSpeedX := readMem(hGTA, dwAddr + ADDR_VEHICLE_X, 4, "float")
    fSpeedY := readMem(hGTA, dwAddr + ADDR_VEHICLE_Y, 4, "float")
    fSpeedZ := readMem(hGTA, dwAddr + ADDR_VEHICLE_Z, 4, "float")
    
    fVehicleSpeed :=  sqrt((fSpeedX * fSpeedX) + (fSpeedY * fSpeedY) + (fSpeedZ * fSpeedZ))
    fVehicleSpeed := (fVehicleSpeed * 100) * 1.43           ;Der Wert "1.43" ist meistens auf jedem Server anders. Die Geschwindigkeit wird somit erhГѓВ¶ht bzw. verringert
 
	return fVehicleSpeed
}

getTargetVehicleSpeedById(dwId) {
    if(!checkHandles())
        return -1
 
    dwAddr := getVehiclePointerById(dwId)
    
    fSpeedX := readMem(hGTA, dwAddr + ADDR_VEHICLE_X, 4, "float")
    fSpeedY := readMem(hGTA, dwAddr + ADDR_VEHICLE_Y, 4, "float")
    fSpeedZ := readMem(hGTA, dwAddr + ADDR_VEHICLE_Z, 4, "float")
    
    fVehicleSpeed :=  sqrt((fSpeedX * fSpeedX) + (fSpeedY * fSpeedY) + (fSpeedZ * fSpeedZ))
    fVehicleSpeed := (fVehicleSpeed * 100) * 1.43           ;Der Wert "1.43" ist meistens auf jedem Server anders. Die Geschwindigkeit wird somit erhГѓВ¶ht bzw. verringert
 
	return fVehicleSpeed
}
; ##### Scoreboard-Funktionen #####

getPlayerNameById(dwId) {
    dwId += 0
    dwId := Floor(dwId)
    if(dwId < 0 || dwId >= SAMP_PLAYER_MAX)
        return ""
    
    if(iRefreshScoreboard+iUpdateTick > A_TickCount)
    {
        if(oScoreboardData[dwId])
            return oScoreboardData[dwId].NAME
        return ""
    }
    
    if(!updateOScoreboardData())
        return ""
    
    if(oScoreboardData[dwId])
        return oScoreboardData[dwId].NAME
    return ""
}

getPlayerIdByName(wName) {
    wName := "" wName
    if(StrLen(wName) < 1 || StrLen(wName) > 24)
        return -1
    
    if(iRefreshScoreboard+iUpdateTick > A_TickCount)
    {
        For i, o in oScoreboardData
        {
            if(InStr(o.NAME,wName)==1)
                return i
        }
        return -1
    }
    
    if(!updateOScoreboardData())
        return -1
    
    For i, o in oScoreboardData
    {
        if(InStr(o.NAME,wName)==1)
            return i
    }
    return -1
}

getPlayerScoreById(dwId) {
    dwId += 0
    dwId := Floor(dwId)
    if(dwId < 0 || dwId >= SAMP_PLAYER_MAX)
        return ""
    
    if(iRefreshScoreboard+iUpdateTick > A_TickCount)
    {
        if(oScoreboardData[dwId])
            return oScoreboardData[dwId].SCORE
        return ""
    }
    
    if(!updateOScoreboardData())
        return ""
    
    if(oScoreboardData[dwId])
        return oScoreboardData[dwId].SCORE
    return ""
}

getPlayerPingById(dwId) {
    dwId += 0
    dwId := Floor(dwId)
    if(dwId < 0 || dwId >= SAMP_PLAYER_MAX)
        return -1
        
    if(iRefreshScoreboard+iUpdateTick > A_TickCount)
    {
        if(oScoreboardData[dwId])
            return oScoreboardData[dwId].PING
        return -1
    }
    
    if(!updateOScoreboardData())
        return -1
    
    if(oScoreboardData[dwId])
        return oScoreboardData[dwId].PING
    return -1
}

isNPCById(dwId) {
    dwId += 0
    dwId := Floor(dwId)
    if(dwId < 0 || dwId >= SAMP_PLAYER_MAX)
        return -1
    
    if(iRefreshScoreboard+iUpdateTick > A_TickCount)
    {
        if(oScoreboardData[dwId])
            return oScoreboardData[dwId].ISNPC
        return -1
    }
    
    if(!updateOScoreboardData())
        return -1
    
    if(oScoreboardData[dwId])
        return oScoreboardData[dwId].ISNPC
    return -1
}

; internal stuff
updateScoreboardDataEx() {
    
    if(!checkHandles())
        return false
    
    dwAddress := readDWORD(hGTA, dwSAMP + SAMP_INFO_OFFSET)            ;g_SAMP
    if(ErrorLevel || dwAddress==0) {
        ErrorLevel := ERROR_READ_MEMORY
        return false
    }
    
    dwFunc := dwSAMP + FUNC_UPDATESCOREBOARD
    
    VarSetCapacity(injectData, 11, 0) ;mov + call + retn
    
    NumPut(0xB9, injectData, 0, "UChar")
    NumPut(dwAddress, injectData, 1, "UInt")
    
    NumPut(0xE8, injectData, 5, "UChar")
    offset := dwFunc - (pInjectFunc + 10)
    NumPut(offset, injectData, 6, "Int")
    NumPut(0xC3, injectData, 10, "UChar")
    
    writeRaw(hGTA, pInjectFunc, &injectData, 11)
    if(ErrorLevel)
        return false
    
    hThread := createRemoteThread(hGTA, 0, 0, pInjectFunc, 0, 0, 0)
    if(ErrorLevel)
        return false
    
    waitForSingleObject(hThread, 0xFFFFFFFF)
    
    closeProcess(hThread)
    
    return true
    
}

; internal stuff
updateOScoreboardData() {
    if(!checkHandles())
        return 0
    
    oScoreboardData := []
    
    if(!updateScoreboardDataEx())
        return 0
    
    iRefreshScoreboard := A_TickCount
    
    dwAddress := readDWORD(hGTA, dwSAMP + SAMP_INFO_OFFSET)
    if(ErrorLevel || dwAddress==0) {
        ErrorLevel := ERROR_READ_MEMORY
        return 0
    }
    
    dwAddress := readDWORD(hGTA, dwAddress + SAMP_PPOOLS_OFFSET)
    if(ErrorLevel || dwAddress==0) {
        ErrorLevel := ERROR_READ_MEMORY
        return 0
    }
    
    dwPlayers := readDWORD(hGTA, dwAddress + SAMP_PPOOL_PLAYER_OFFSET)
    if(ErrorLevel || dwPlayers==0) {
        ErrorLevel := ERROR_READ_MEMORY
        return 0
    }
    
    wID := readMem(hGTA, dwPlayers + SAMP_SLOCALPLAYERID_OFFSET, 2, "Short")    ;sLocalPlayerID
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return 0
    }
    
    dwPing := readMem(hGTA, dwPlayers + SAMP_ILOCALPLAYERPING_OFFSET, 4, "Int")
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return 0
    }
    
    dwScore := readMem(hGTA, dwPlayers + SAMP_ILOCALPLAYERSCORE_OFFSET, 4, "Int")
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return 0
    }
    
    dwTemp := readMem(hGTA, dwPlayers + SAMP_ISTRLEN_LOCALPLAYERNAME_OFFSET, 4, "Int")    ;iStrlen_LocalPlayerName
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return 0
    }
    
    sUsername := ""
    if(dwTemp <= 0xf) {
        sUsername := readString(hGTA, dwPlayers + SAMP_SZLOCALPLAYERNAME_OFFSET, 16)       ;szLocalPlayerName
        if(ErrorLevel) {
            ErrorLevel := ERROR_READ_MEMORY
            return 0
        }
    }
    else {
        dwAddress := readDWORD(hGTA, dwPlayers + SAMP_PSZLOCALPLAYERNAME_OFFSET)        ;pszLocalPlayerName
        if(ErrorLevel) {
            ErrorLevel := ERROR_READ_MEMORY
            return 0
        }
        sUsername := readString(hGTA, dwAddress, 25)
        if(ErrorLevel) {
            ErrorLevel := ERROR_READ_MEMORY
            return 0
        }
    }
    oScoreboardData[wID] := Object("NAME", sUsername, "ID", wID, "PING", dwPing, "SCORE", dwScore, "ISNPC", 0)
    
    Loop, % SAMP_PLAYER_MAX
    {
        i := A_Index-1
        
        dwRemoteplayer := readDWORD(hGTA, dwPlayers+SAMP_PREMOTEPLAYER_OFFSET+i*4)      ;pRemotePlayer
        if(ErrorLevel) {
            ErrorLevel := ERROR_READ_MEMORY
            return 0
        }
        
        if(dwRemoteplayer==0)
            continue
        
        dwPing := readMem(hGTA, dwRemoteplayer + SAMP_IPING_OFFSET, 4, "Int")
        if(ErrorLevel) {
            ErrorLevel := ERROR_READ_MEMORY
            return 0
        }
        
        dwScore := readMem(hGTA, dwRemoteplayer + SAMP_ISCORE_OFFSET, 4, "Int")
        if(ErrorLevel) {
            ErrorLevel := ERROR_READ_MEMORY
            return 0
        }
        
        dwIsNPC := readMem(hGTA, dwRemoteplayer + SAMP_ISNPC_OFFSET, 4, "Int")
        if(ErrorLevel) {
            ErrorLevel := ERROR_READ_MEMORY
            return 0
        }
        
        dwTemp := readMem(hGTA, dwRemoteplayer + SAMP_ISTRLENNAME___OFFSET, 4, "Int")
        if(ErrorLevel) {
            ErrorLevel := ERROR_READ_MEMORY
            return 0
        }
        sUsername := ""
        if(dwTemp <= 0xf)
        {
            sUsername := readString(hGTA, dwRemoteplayer+SAMP_SZPLAYERNAME_OFFSET, 16)
            if(ErrorLevel) {
                ErrorLevel := ERROR_READ_MEMORY
                return 0
            }
        }
        else {
            dwAddress := readDWORD(hGTA, dwRemoteplayer + SAMP_PSZPLAYERNAME_OFFSET)
            if(ErrorLevel || dwAddress==0) {
                ErrorLevel := ERROR_READ_MEMORY
                return 0
            }
            sUsername := readString(hGTA, dwAddress, 25)
            if(ErrorLevel) {
                ErrorLevel := ERROR_READ_MEMORY
                return 0
            }
        }
        o := Object("NAME", sUsername, "ID", i, "PING", dwPing, "SCORE", dwScore, "ISNPC", dwIsNPC)
        oScoreboardData[i] := o
        
        dwRemoteplayerData := readDWORD(hGTA, dwRemoteplayer + 0x0)                ;pPlayerData
        if(ErrorLevel) {
            ErrorLevel := ERROR_READ_MEMORY
            return 0
        }
        if(dwRemoteplayerData==0)		;this ever happen?
            continue
		
		dwAddress := readDWORD(hGTA, dwRemoteplayerData + 489)        ;iGlobalMarkerLoaded
        if(ErrorLevel) {
            ErrorLevel := ERROR_READ_MEMORY
            return 0
        }
		if(dwAddress)
		{
			ix := readMem(hGTA, dwRemoteplayerData + 493, 4, "Int")        ;x map
			if(ErrorLevel) {
				ErrorLevel := ERROR_READ_MEMORY
				return 0
			}
			iy := readMem(hGTA, dwRemoteplayerData + 497, 4, "Int")        ;y map
			if(ErrorLevel) {
				ErrorLevel := ERROR_READ_MEMORY
				return 0
			}
			iz := readMem(hGTA, dwRemoteplayerData + 501, 4, "Int")        ;z map
			if(ErrorLevel) {
				ErrorLevel := ERROR_READ_MEMORY
				return 0
			}
			o.MPOS := [ix, iy, iz]
		}
        
        dwpSAMP_Actor := readDWORD(hGTA, dwRemoteplayerData + 0x0)                ;pSAMP_Actor
        if(ErrorLevel) {
            ErrorLevel := ERROR_READ_MEMORY
            return 0
        }
        if(dwpSAMP_Actor==0)               ;not streamed in
            continue

        dwPed := readDWORD(hGTA, dwpSAMP_Actor + 676)                ;pGTA_Ped_
        if(ErrorLevel) {
            ErrorLevel := ERROR_READ_MEMORY
            return 0
        }
        if(dwPed==0)
            continue
        o.PED := dwPed
		
		fHP := readFloat(hGTA, dwRemoteplayerData + 444)
		if(ErrorLevel) {
            ErrorLevel := ERROR_READ_MEMORY
            return 0
        }
		fARMOR := readFloat(hGTA, dwRemoteplayerData + 440)
		if(ErrorLevel) {
            ErrorLevel := ERROR_READ_MEMORY
            return 0
        }
		o.HP := fHP
		o.ARMOR := fARMOR
    }
    ErrorLevel := ERROR_OK
    return 1
}


; ##### Sonstiges #####
; written by David_Luchs %
; returns nth message of chatlog (beggining from bottom)
; -1 = error
GetChatLine(Line, ByRef Output, timestamp=0, color=0){
	chatindex := 0
	FileRead, file, %A_MyDocuments%\GTA San Andreas User Files\SAMP\chatlog.txt
	loop, Parse, file, `n, `r
	{
		if(A_LoopField)
			chatindex := A_Index
	}
	loop, Parse, file, `n, `r
	{
		if(A_Index = chatindex - line){
			output := A_LoopField
			break
		}
	}
	file := ""
	if(!timestamp)
		output := RegExReplace(output, "U)^\[\d{2}:\d{2}:\d{2}\]")
	if(!color)
		output := RegExReplace(output, "Ui)\{[a-f0-9]{6}\}")
	return
} 

; ##### Spielerfunktionen #####
getPlayerHealth() {
    if(!checkHandles())
        return -1
    
    dwCPedPtr := readDWORD(hGTA, ADDR_CPED_PTR)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    dwAddr := dwCPedPtr + ADDR_CPED_HPOFF
    fHealth := readFloat(hGTA, dwAddr)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    ErrorLevel := ERROR_OK
    return Round(fHealth)
}

getPlayerArmor() {
    if(!checkHandles())
        return -1
    
    dwCPedPtr := readDWORD(hGTA, ADDR_CPED_PTR)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    dwAddr := dwCPedPtr + ADDR_CPED_ARMOROFF
    fHealth := readFloat(hGTA, dwAddr)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    ErrorLevel := ERROR_OK
    return Round(fHealth)
}

getPlayerInteriorId() {
    if(!checkHandles())
        return -1
    
    iid := readMem(hGTA, ADDR_CPED_INTID, 4, "Int")
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    ErrorLevel := ERROR_OK
    return iid
}

getPlayerSkinID() {
    if(!checkHandles())
        return -1
    
    dwCPedPtr := readDWORD(hGTA, ADDR_CPED_PTR)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    dwAddr := dwCPedPtr + ADDR_CPED_SKINIDOFF
    SkinID := readMem(hGTA, dwAddr, 2, "byte")
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    ErrorLevel := ERROR_OK
    return SkinID
}

getPlayerMoney() {
    if(!checkHandles())
        return ""
    
    money := readMem(hGTA, ADDR_CPED_MONEY, 4, "Int")
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return ""
    }
    
    ErrorLevel := ERROR_OK
    return money
}

getPlayerWanteds() {
    if(!checkHandles())
        return -1
 
    dwPtr := 0xB7CD9C
    dwPtr := readDWORD(hGTA, dwPtr)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
 
    Wanteds := readDWORD(hGTA, dwPtr)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
 
    ErrorLevel := ERROR_OK
    return Wanteds
}

getPlayerWeaponId() {
    if(!checkHandles())
        return 0
    
    WaffenId := readMem(hGTA, 0xBAA410, 4, "byte")
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }

   return WaffenId
}

getPlayerWeaponName() {
    id := getPlayerWeaponId()
    if(id >= 0 && id < 44)
    {
        return oweaponNames[id+1]
    }
    return ""
}

getPlayerState() {
    if(!checkHandles())
        return -1
    
    dwCPedPtr := readDWORD(hGTA, ADDR_CPED_PTR)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    State := readDWORD(hGTA, dwCPedPtr + 0x530)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    ErrorLevel := ERROR_OK
    return State
}

IsPlayerInMenu() {
    if(!checkHandles())
        return -1
    
    IsInMenu := readMem(hGTA, 0xBA67A4, 4, "byte")
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    ErrorLevel := ERROR_OK
    return IsInMenu
}

getPlayerMapPosX() {
    if(!checkHandles())
        return -1
    
    MapPosX := readFloat(hGTA, 0xBA67B8)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    ErrorLevel := ERROR_OK
    return MapPosX
}

getPlayerMapPosY() {
    if(!checkHandles())
        return -1
    
    MapPosY := readFloat(hGTA, 0xBA67BC)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    ErrorLevel := ERROR_OK
    return MapPosY
}

getPlayerMapZoom() {
    if(!checkHandles())
        return -1
    
    MapZoom := readFloat(hGTA, 0xBA67AC)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    ErrorLevel := ERROR_OK
    return MapZoom
}

IsPlayerFreezed() {
    if(!checkHandles())
        return -1
    
    dwGTA := getModuleBaseAddress("gta_sa.exe", hGTA)
    IPF := readMem(hGTA, dwGTA + 0x690495, 2, "byte")    
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    ErrorLevel := ERROR_OK    
    return IPF
}

; ##### Fahrzeugfunktionen #####

isPlayerInAnyVehicle()
{
    if(!checkHandles())
        return -1
    
    dwVehPtr := readDWORD(hGTA, ADDR_VEHICLE_PTR)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    return (dwVehPtr > 0)
}

isPlayerDriver() {
    if(!checkHandles())
        return -1
    
    dwAddr := readDWORD(hGTA, ADDR_VEHICLE_PTR)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    if(!dwAddr)
        return -1
    
    dwCPedPtr := readDWORD(hGTA, ADDR_CPED_PTR)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    dwVal := readDWORD(hGTA, dwAddr + ADDR_VEHICLE_DRIVER)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    ErrorLevel := ERROR_OK
    return (dwVal==dwCPedPtr)
}

getVehicleHealth() {
    if(!checkHandles())
        return -1
    
    dwVehPtr := readDWORD(hGTA, ADDR_VEHICLE_PTR)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    dwAddr := dwVehPtr + ADDR_VEHICLE_HPOFF
    fHealth := readFloat(hGTA, dwAddr)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    ErrorLevel := ERROR_OK
    return Round(fHealth)
}

getVehicleType() {
    if(!checkHandles())
        return 0
    
    dwAddr := readDWORD(hGTA, ADDR_VEHICLE_PTR)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return 0
    }
    
    if(!dwAddr)
        return 0
    
    cVal := readMem(hGTA, dwAddr + ADDR_VEHICLE_TYPE, 1, "Char")
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return 0
    }
    
    ErrorLevel := ERROR_OK
    if(!cVal)
    {
        mid := getVehicleModelId()
        Loop % oAirplaneModels.MaxIndex()
        {
            if(oAirplaneModels[A_Index]==mid)
                return 5
        }
        return 1
    }
    else if(cVal==5)
        return 2
    else if(cVal==6)
        return 3
    else if(cVal==9)
    {
        mid := getVehicleModelId()
        Loop % oBikeModels.MaxIndex()
        {
            if(oBikeModels[A_Index]==mid)
                return 6
        }
        return 4
    }
    return 0
}

getVehicleModelId() {
    if(!checkHandles())
        return 0
    
    dwAddr := readDWORD(hGTA, ADDR_VEHICLE_PTR)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return 0
    }
    
    if(!dwAddr)
        return 0
    
    sVal := readMem(hGTA, dwAddr + ADDR_VEHICLE_MODEL, 2, "Short")
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return 0
    }
    
    ErrorLevel := ERROR_OK
    return sVal
}

getVehicleModelName() {
    id:=getVehicleModelId()
    if(id > 400 && id < 611)
    {
        return ovehicleNames[id-399]
    }
    return ""
}


getVehicleLightState() {
    if(!checkHandles())
        return -1
    
    dwAddr := readDWORD(hGTA, ADDR_VEHICLE_PTR)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    if(!dwAddr)
        return -1
    
    dwVal := readMem(hGTA, dwAddr + ADDR_VEHICLE_LIGHTSTATE, 1, "byte")
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    ErrorLevel := ERROR_OK
    return (dwVal>0)
}

getVehicleEngineState() {
    if(!checkHandles())
        return -1
    
    dwAddr := readDWORD(hGTA, ADDR_VEHICLE_PTR)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    if(!dwAddr)
        return -1
    
    cVal := readMem(hGTA, dwAddr + ADDR_VEHICLE_ENGINESTATE, 1, "Char")
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    ErrorLevel := ERROR_OK
    return (cVal==24 || cVal==56 || cVal==88 || cVal==120)
}


getVehicleSirenState() {
    if(!checkHandles())
        return -1
    
    dwAddr := readDWORD(hGTA, ADDR_VEHICLE_PTR)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    if(!dwAddr)
        return -1

    cVal := readMem(hGTA, dwAddr + ADDR_VEHICLE_SIRENSTATE, 1, "Char")
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    ErrorLevel := ERROR_OK
    return (cVal==-48)
}

getVehicleLockState() {
    if(!checkHandles())
        return -1
    
    dwAddr := readDWORD(hGTA, ADDR_VEHICLE_PTR)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    if(!dwAddr)
        return -1
    
    dwVal := readDWORD(hGTA, dwAddr + ADDR_VEHICLE_DOORSTATE)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    ErrorLevel := ERROR_OK
    return (dwVal==2)
}
getVehicleColor1() {
    if(!checkHandles())
        return 0
    
    dwAddr := readDWORD(hGTA, 0xBA18FC)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return 0
    }
    
    if(!dwAddr)
        return 0
	
    sVal := readMem(hGTA, dwAddr + 1076, 1, "byte")
	
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return 0
    }
    
    ErrorLevel := ERROR_OK
    return sVal
}

getVehicleColor2() {
    if(!checkHandles())
        return 0
    
    dwAddr := readDWORD(hGTA, 0xBA18FC)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return 0
    }
    
    if(!dwAddr)
        return 0
	
    sVal := readMem(hGTA, dwAddr + 1077, 1, "byte")
	
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return 0
    }
    
    ErrorLevel := ERROR_OK
    return sVal
}

getVehicleSpeed() {
    if(!checkHandles())
        return -1
 
    dwAddr := readDWORD(hGTA, ADDR_VEHICLE_PTR)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return ""
    }
    
    fSpeedX := readMem(hGTA, dwAddr + ADDR_VEHICLE_X, 4, "float")
    fSpeedY := readMem(hGTA, dwAddr + ADDR_VEHICLE_Y, 4, "float")
    fSpeedZ := readMem(hGTA, dwAddr + ADDR_VEHICLE_Z, 4, "float")
    
    fVehicleSpeed :=  sqrt((fSpeedX * fSpeedX) + (fSpeedY * fSpeedY) + (fSpeedZ * fSpeedZ))
    fVehicleSpeed := (fVehicleSpeed * 100) * 1.43           ;Der Wert "1.43" ist meistens auf jedem Server anders. Die Geschwindigkeit wird somit erhГѓВ¶ht bzw. verringert
 
	return fVehicleSpeed
}

getPlayerRadiostationID() {
    if(!checkHandles())
        return -1
    
    if(isPlayerInAnyVehicle() == 0)
        return -1
    
    dwGTA := getModuleBaseAddress("gta_sa.exe", hGTA)
    RadioStationID := readMem(hGTA, dwGTA + 0x4CB7E1, 1, "byte")
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return -1
    }
    
    return RadioStationID
}

getPlayerRadiostationName() {
    if(isPlayerInAnyVehicle() == 0)
        return -1
    
    id := getPlayerRadiostationID()
    
    if(id == 0)
        return -1
    
    if(id >= 0 && id < 14)
    {
        return oradiostationNames[id]
    }
    return ""
}

; ##### Checkpointsachen #####
setCheckpoint(fX, fY, fZ, fSize ) {
    if(!checkHandles())
        return false
    dwFunc := dwSAMP + 0x9D340
    dwAddress := readDWORD(hGTA, dwSAMP + ADDR_SAMP_INCHAT_PTR) ;misc info
    if(ErrorLevel || dwAddress==0) {
        ErrorLevel := ERROR_READ_MEMORY
        return false
    }
    VarSetCapacity(buf, 16, 0)
    NumPut(fX, buf, 0, "Float")
    NumPut(fY, buf, 4, "Float")
    NumPut(fZ, buf, 8, "Float")
    NumPut(fSize, buf, 12, "Float")
    writeRaw(hGTA, pParam1, &buf, 16)
    dwLen := 31
    VarSetCapacity(injectData, dwLen, 0)
    NumPut(0xB9, injectData, 0, "UChar")
    NumPut(dwAddress, injectData, 1, "UInt")
    NumPut(0x68, injectData, 5, "UChar")
    NumPut(pParam1+12, injectData, 6, "UInt")
    NumPut(0x68, injectData, 10, "UChar")
    NumPut(pParam1, injectData, 11, "UInt")
    NumPut(0xE8, injectData, 15, "UChar")
    offset := dwFunc - (pInjectFunc + 20)
    NumPut(offset, injectData, 16, "Int")
    NumPut(0x05C7, injectData, 20, "UShort")
    NumPut(dwAddress+0x24, injectData, 22, "UInt")
    NumPut(1, injectData, 26, "UInt")
    NumPut(0xC3, injectData, 30, "UChar")
    writeRaw(hGTA, pInjectFunc, &injectData, dwLen)
    if(ErrorLevel)
        return false
    hThread := createRemoteThread(hGTA, 0, 0, pInjectFunc, 0, 0, 0)
    if(ErrorLevel)
        return false
    waitForSingleObject(hThread, 0xFFFFFFFF)
    closeProcess(hThread)
    ErrorLevel := ERROR_OK
    return true
}

disableCheckpoint()
{
    if(!checkHandles())
        return false
    dwAddress := readDWORD(hGTA, dwSAMP + ADDR_SAMP_INCHAT_PTR) ;misc info
    if(ErrorLevel || dwAddress==0) {
        ErrorLevel := ERROR_READ_MEMORY
        return false
    }
    VarSetCapacity(enablecp, 4, 0)
    NumPut(0,enablecp,0,"Int")
    writeRaw(hGTA, dwAddress+0x24, &enablecp, 4)
    ErrorLevel := ERROR_OK
    return true
}

IsMarkerCreated(){
    If(!checkHandles())
        return false
    active := readMem(hGTA, CheckpointCheck, 1, "byte")
    If(!active)
        return 0
    else return 1
}
CoordsFromRedmarker(){
    if(!checkhandles())
        return false
    for i, v in rmaddrs
    f%i% := readFloat(hGTA, v)
    return [f1, f2, f3]
}
; ##### Positionsbestimmung #####
getCoordinates() {
    if(!checkHandles())
        return ""
    
    fX := readFloat(hGTA, ADDR_POSITION_X)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return ""
    }
    
    fY := readFloat(hGTA, ADDR_POSITION_Y)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return ""
    }
    
    fZ := readFloat(hGTA, ADDR_POSITION_Z)
    if(ErrorLevel) {
        ErrorLevel := ERROR_READ_MEMORY
        return ""
    }
    
    ErrorLevel := ERROR_OK
    return [fX, fY, fZ]
}

GetPlayerPos(ByRef fX,ByRef fY,ByRef fZ) {
        if(!checkHandles())
                return 0
 
        fX := readFloat(hGTA, ADDR_POSITION_X)
        if(ErrorLevel) {
                ErrorLevel := ERROR_READ_MEMORY
                return 0
        }
 
        fY := readFloat(hGTA, ADDR_POSITION_Y)
        if(ErrorLevel) {
                ErrorLevel := ERROR_READ_MEMORY
                return 0
        }
 
        fZ := readFloat(hGTA, ADDR_POSITION_Z)
        if(ErrorLevel) {
                ErrorLevel := ERROR_READ_MEMORY
                return 0
        }
 
        ErrorLevel := ERROR_OK
}

; ######################### Dialog Functions #########################
getDialogStructPtr() {
	if (!checkHandles()) {
		ErrorLevel := ERROR_INVALID_HANDLE
		return false
	}

	dwPointer := readDWORD(hGTA, dwSAMP + SAMP_DIALOG_STRUCT_PTR)
	if (ErrorLevel) {
		ErrorLevel := ERROR_READ_MEMORY
		return false
	}

	ErrorLevel := ERROR_OK
	return dwPointer
}

isDialogOpen() {
	dwPointer := getDialogStructPtr()
	if (ErrorLevel || !dwPointer)
	return false

	dwIsOpen := readMem(hGTA, dwPointer + SAMP_DIALOG_OPEN_OFFSET, 4, "UInt")
	if (ErrorLevel) {
		ErrorLevel := ERROR_READ_MEMORY
		return false
	}
	
	ErrorLevel := ERROR_OK
	return dwIsOpen ? true : false
}

getDialogStyle() {
	dwPointer := getDialogStructPtr()
	if (ErrorLevel || !dwPointer)
		return -1

	style := readMem(hGTA, dwPointer + SAMP_DIALOG_STYLE_OFFSET, 4, "UInt")
	if (ErrorLevel) {
		ErrorLevel := ERROR_READ_MEMORY
		return -1
	}

	ErrorLevel := ERROR_OK
	return style
}

getDialogID() {
	dwPointer := getDialogStructPtr()
	if (ErrorLevel || !dwPointer)
		return -1

	id := readMem(hGTA, dwPointer + SAMP_DIALOG_ID_OFFSET, 4, "UInt")
	if (ErrorLevel) {
		ErrorLevel := ERROR_READ_MEMORY
		return -1
	}

	ErrorLevel := ERROR_OK
	return id
}

setDialogID(id) {
	dwPointer := getDialogStructPtr()
	if (ErrorLevel || !dwPointer)
		return false

	writeMemory(hGTA, dwPointer + SAMP_DIALOG_ID_OFFSET, id, "UInt", 4)
	if (ErrorLevel) {
		ErrorLevel := ERROR_WRITE_MEMORY
		return false
	}

	ErrorLevel := ERROR_OK
	return true
}

getDialogCaption() {
	dwPointer := getDialogStructPtr()
	if (ErrorLevel || !dwPointer)
		return ""

	text := readString(hGTA, dwPointer + SAMP_DIALOG_CAPTION_OFFSET, 64)
	if (ErrorLevel) {
		ErrorLevel := ERROR_READ_MEMORY
		return ""
	}

	ErrorLevel := ERROR_OK
	return text
}

getDialogTextSize(dwAddress) {
	i := 0
	Loop, 4096 {
		i := A_Index - 1
		byte := Memory_ReadByte(hGTA, dwAddress + i)
		if (!byte)
			break
	}

	return i
}

getDialogText() {
	dwPointer := getDialogStructPtr()
	if (ErrorLevel || !dwPointer)
		return ""

	dwPointer := readDWORD(hGTA, dwPointer + SAMP_DIALOG_TEXT_PTR_OFFSET)
	if (ErrorLevel) {
		ErrorLevel := ERROR_READ_MEMORY
		return ""
	}

	text := readString(hGTA, dwPointer, 4096)
	if (ErrorLevel) {
		text := readString(hGTA, dwPointer, getDialogTextSize(dwPointer))
		if (ErrorLevel) {
			ErrorLevel := ERROR_READ_MEMORY
			return ""
		}
	}

	ErrorLevel := ERROR_OK
	return text
}

getDialogLineCount() {
	dwPointer := getDialogStructPtr()
	if (ErrorLevel || !dwPointer)
		return 0

	dwPointer := readDWORD(hGTA, dwPointer + SAMP_DIALOG_PTR2_OFFSET)
	if (ErrorLevel) {
		ErrorLevel := ERROR_READ_MEMORY
		return 0
	}

	count := readMem(hGTA, dwPointer + SAMP_DIALOG_LINECOUNT_OFFSET, 4, "UInt")
	if (ErrorLevel) {
		ErrorLevel := ERROR_READ_MEMORY
		return 0
	}

	ErrorLevel := ERROR_OK
	return count
}

getDialogLine__(index) {
	if (getDialogLineCount > index)
		return ""

	dwPointer := getDialogStructPtr()
	if (ErrorLevel || !dwPointer)
		return ""

	dwPointer := readDWORD(hGTA, dwPointer + SAMP_DIALOG_PTR1_OFFSET)
	if (ErrorLevel) {
		ErrorLevel := ERROR_READ_MEMORY
		return ""
	}

	dwPointer := readDWORD(hGTA, dwPointer + SAMP_DIALOG_LINES_OFFSET)
	if (ErrorLevel) {
		ErrorLevel := ERROR_READ_MEMORY
		return ""
	}

	dwLineAddress := readDWORD(hGTA, dwPointer + (index - 1) * 0x4)
	line := readString(hGTA, dwLineAddress, 128)

	ErrorLevel := ERROR_OK
	return line
}

getDialogLine(index) {
	lines := getDialogLines()
	if (index > lines.Length())
		return ""

	if (getDialogStyle() == DIALOG_STYLE_TABLIST_HEADERS)
		index++

	return lines[index]
}

getDialogLines() {
	text := getDialogText()
	if (text == "")
		return -1

	lines := StrSplit(text, "`n")
	return lines
}


getDialogLines__() {
	count := getDialogLineCount()

	dwPointer := getDialogStructPtr()
	if (ErrorLevel || !dwPointer)
		return -1

	dwPointer := readDWORD(hGTA, dwPointer + SAMP_DIALOG_PTR1_OFFSET)
	if (ErrorLevel) {
		ErrorLevel := ERROR_READ_MEMORY
		return -1
	}

	dwPointer := readDWORD(hGTA, dwPointer + SAMP_DIALOG_LINES_OFFSET)
	if (ErrorLevel) {
		ErrorLevel := ERROR_READ_MEMORY
		return -1
	}

	lines := []
	Loop %count% {
		dwLineAddress := readDWORD(hGTA, dwPointer + (A_Index - 1) * 0x4)
		lines[A_Index] := readString(hGTA, dwLineAddress, 128)
	}

	ErrorLevel := ERROR_OK
	return lines
}

showDialog(style, caption, text, button1, button2 := "", id := 1) {
	style += 0
	style := Floor(style)
	id += 0
	id := Floor(id)
	caption := "" caption
	text := "" text
	button1 := "" button1
	button2 := "" button2

	if (id < 0 || id > 32767 || style < 0 || style > 5 || StrLen(caption) > 64 || StrLen(text) > 4096 || StrLen(button1) > 10 || StrLen(button2) > 10)
		return false

	if (!checkHandles())
		return false

	dwFunc := dwSAMP + FUNC_SAMP_SHOWDIALOG
    sleep 200
	dwAddress := readDWORD(hGTA, dwSAMP + SAMP_DIALOG_STRUCT_PTR)
	if (ErrorLevel || !dwAddress) {
		ErrorLevel := ERROR_READ_MEMORY
		return false
	}

	writeString(hGTA, pParam5, caption)
	if (ErrorLevel)
		return false
	writeString(hGTA, pParam1, text)
	if (ErrorLevel)
		return false
	writeString(hGTA, pParam5 + 512, button1)
	if (ErrorLevel)
		return false
	writeString(hGTA, pParam5+StrLen(caption) + 1, button2)
	if (ErrorLevel)
		return false

	;mov + 7 * push + call + retn
	dwLen := 5 + 7 * 5 + 5 + 1
	VarSetCapacity(injectData, dwLen, 0)

	NumPut(0xB9, injectData, 0, "UChar")							;0 + 1	;mov ecx
	NumPut(dwAddress, injectData, 1, "UInt")						;1 + 4
	NumPut(0x68, injectData, 5, "UChar")							;5 + 1	;push send
	NumPut(1, injectData, 6, "UInt")								;6 + 4
	NumPut(0x68, injectData, 10, "UChar")							;10 + 1	;push button2
	NumPut(pParam5 + StrLen(caption) + 1, injectData, 11, "UInt")	;11 + 4
	NumPut(0x68, injectData, 15, "UChar")							;15 + 1	;push button1
	NumPut(pParam5 + 512, injectData, 16, "UInt")					;16 + 4
	NumPut(0x68, injectData, 20, "UChar")							;20 + 1	;push text
	NumPut(pParam1, injectData, 21, "UInt")							;21 + 4
	NumPut(0x68, injectData, 25, "UChar")							;25 + 1	;push caption
	NumPut(pParam5, injectData, 26, "UInt")							;26 + 4
	NumPut(0x68, injectData, 30, "UChar")							;30 + 1	;push style
	NumPut(style, injectData, 31, "UInt")							;31 + 4
	NumPut(0x68, injectData, 35, "UChar")							;35 + 1	;push id
	NumPut(id, injectData, 36, "UInt")								;36 + 4

	NumPut(0xE8, injectData, 40, "UChar")							;40 + 1 ;call
	offset := dwFunc - (pInjectFunc + 45)
	NumPut(offset, injectData, 41, "Int")							;41 + 4
	NumPut(0xC3, injectData, 45, "UChar")							;45 + 1	;retn

	writeRaw(hGTA, pInjectFunc, &injectData, dwLen)
	if (ErrorLevel)
		return false

	hThread := createRemoteThread(hGTA, 0, 0, pInjectFunc, 0, 0, 0)
	if (ErrorLevel)
		return false

	waitForSingleObject(hThread, 0xFFFFFFFF)
	closeProcess(hThread)

	return true
}


initZonesAndCities() {
    AddCity("Las Venturas", 685.0, 476.093, -500.0, 3000.0, 3000.0, 500.0)
    AddCity("San Fierro", -3000.0, -742.306, -500.0, -1270.53, 1530.24, 500.0)
    AddCity("San Fierro", -1270.53, -402.481, -500.0, -1038.45, 832.495, 500.0)
    AddCity("San Fierro", -1038.45, -145.539, -500.0, -897.546, 376.632, 500.0)
    AddCity("Los Santos", 480.0, -3000.0, -500.0, 3000.0, -850.0, 500.0)
    AddCity("Los Santos", 80.0, -2101.61, -500.0, 1075.0, -1239.61, 500.0)
    AddCity("Tierra Robada", -1213.91, 596.349, -242.99, -480.539, 1659.68, 900.0)
    AddCity("Red County", -1213.91, -768.027, -242.99, 2997.06, 596.349, 900.0)
    AddCity("Flint County", -1213.91, -2892.97, -242.99, 44.6147, -768.027, 900.0)
    AddCity("Whetstone", -2997.47, -2892.97, -242.99, -1213.91, -1115.58, 900.0)
    
    AddZone("Avispa Country Club", -2667.810, -302.135, -28.831, -2646.400, -262.320, 71.169)
    AddZone("Easter Bay Airport", -1315.420, -405.388, 15.406, -1264.400, -209.543, 25.406)
    AddZone("Avispa Country Club", -2550.040, -355.493, 0.000, -2470.040, -318.493, 39.700)
    AddZone("Easter Bay Airport", -1490.330, -209.543, 15.406, -1264.400, -148.388, 25.406)
    AddZone("Garcia", -2395.140, -222.589, -5.3, -2354.090, -204.792, 200.000)
    AddZone("Shady Cabin", -1632.830, -2263.440, -3.0, -1601.330, -2231.790, 200.000)
    AddZone("East Los Santos", 2381.680, -1494.030, -89.084, 2421.030, -1454.350, 110.916)
    AddZone("LVA Freight Depot", 1236.630, 1163.410, -89.084, 1277.050, 1203.280, 110.916)
    AddZone("Blackfield Intersection", 1277.050, 1044.690, -89.084, 1315.350, 1087.630, 110.916)
    AddZone("Avispa Country Club", -2470.040, -355.493, 0.000, -2270.040, -318.493, 46.100)
    AddZone("Temple", 1252.330, -926.999, -89.084, 1357.000, -910.170, 110.916)
    AddZone("Unity Station", 1692.620, -1971.800, -20.492, 1812.620, -1932.800, 79.508)
    AddZone("LVA Freight Depot", 1315.350, 1044.690, -89.084, 1375.600, 1087.630, 110.916)
    AddZone("Los Flores", 2581.730, -1454.350, -89.084, 2632.830, -1393.420, 110.916)
    AddZone("Starfish Casino", 2437.390, 1858.100, -39.084, 2495.090, 1970.850, 60.916)
    AddZone("Easter Bay Chemicals", -1132.820, -787.391, 0.000, -956.476, -768.027, 200.000)
    AddZone("Downtown Los Santos", 1370.850, -1170.870, -89.084, 1463.900, -1130.850, 110.916)
    AddZone("Esplanade East", -1620.300, 1176.520, -4.5, -1580.010, 1274.260, 200.000)
    AddZone("Market Station", 787.461, -1410.930, -34.126, 866.009, -1310.210, 65.874)
    AddZone("Linden Station", 2811.250, 1229.590, -39.594, 2861.250, 1407.590, 60.406)
    AddZone("Montgomery Intersection", 1582.440, 347.457, 0.000, 1664.620, 401.750, 200.000)
    AddZone("Frederick Bridge", 2759.250, 296.501, 0.000, 2774.250, 594.757, 200.000)
    AddZone("Yellow Bell Station", 1377.480, 2600.430, -21.926, 1492.450, 2687.360, 78.074)
    AddZone("Downtown Los Santos", 1507.510, -1385.210, 110.916, 1582.550, -1325.310, 335.916)
    AddZone("Jefferson", 2185.330, -1210.740, -89.084, 2281.450, -1154.590, 110.916)
    AddZone("Mulholland", 1318.130, -910.170, -89.084, 1357.000, -768.027, 110.916)
    AddZone("Avispa Country Club", -2361.510, -417.199, 0.000, -2270.040, -355.493, 200.000)
    AddZone("Jefferson", 1996.910, -1449.670, -89.084, 2056.860, -1350.720, 110.916)
    AddZone("Julius Thruway West", 1236.630, 2142.860, -89.084, 1297.470, 2243.230, 110.916)
    AddZone("Jefferson", 2124.660, -1494.030, -89.084, 2266.210, -1449.670, 110.916)
    AddZone("Julius Thruway North", 1848.400, 2478.490, -89.084, 1938.800, 2553.490, 110.916)
    AddZone("Rodeo", 422.680, -1570.200, -89.084, 466.223, -1406.050, 110.916)
    AddZone("Cranberry Station", -2007.830, 56.306, 0.000, -1922.000, 224.782, 100.000)
    AddZone("Downtown Los Santos", 1391.050, -1026.330, -89.084, 1463.900, -926.999, 110.916)
    AddZone("Redsands West", 1704.590, 2243.230, -89.084, 1777.390, 2342.830, 110.916)
    AddZone("Little Mexico", 1758.900, -1722.260, -89.084, 1812.620, -1577.590, 110.916)
    AddZone("Blackfield Intersection", 1375.600, 823.228, -89.084, 1457.390, 919.447, 110.916)
    AddZone("Los Santos International", 1974.630, -2394.330, -39.084, 2089.000, -2256.590, 60.916)
    AddZone("Beacon Hill", -399.633, -1075.520, -1.489, -319.033, -977.516, 198.511)
    AddZone("Rodeo", 334.503, -1501.950, -89.084, 422.680, -1406.050, 110.916)
    AddZone("Richman", 225.165, -1369.620, -89.084, 334.503, -1292.070, 110.916)
    AddZone("Downtown Los Santos", 1724.760, -1250.900, -89.084, 1812.620, -1150.870, 110.916)
    AddZone("The Strip", 2027.400, 1703.230, -89.084, 2137.400, 1783.230, 110.916)
    AddZone("Downtown Los Santos", 1378.330, -1130.850, -89.084, 1463.900, -1026.330, 110.916)
    AddZone("Blackfield Intersection", 1197.390, 1044.690, -89.084, 1277.050, 1163.390, 110.916)
    AddZone("Conference Center", 1073.220, -1842.270, -89.084, 1323.900, -1804.210, 110.916)
    AddZone("Montgomery", 1451.400, 347.457, -6.1, 1582.440, 420.802, 200.000)
    AddZone("Foster Valley", -2270.040, -430.276, -1.2, -2178.690, -324.114, 200.000)
    AddZone("Blackfield Chapel", 1325.600, 596.349, -89.084, 1375.600, 795.010, 110.916)
    AddZone("Los Santos International", 2051.630, -2597.260, -39.084, 2152.450, -2394.330, 60.916)
    AddZone("Mulholland", 1096.470, -910.170, -89.084, 1169.130, -768.027, 110.916)
    AddZone("Yellow Bell Gol Course", 1457.460, 2723.230, -89.084, 1534.560, 2863.230, 110.916)
    AddZone("The Strip", 2027.400, 1783.230, -89.084, 2162.390, 1863.230, 110.916)
    AddZone("Jefferson", 2056.860, -1210.740, -89.084, 2185.330, -1126.320, 110.916)
    AddZone("Mulholland", 952.604, -937.184, -89.084, 1096.470, -860.619, 110.916)
    AddZone("Aldea Malvada", -1372.140, 2498.520, 0.000, -1277.590, 2615.350, 200.000)
    AddZone("Las Colinas", 2126.860, -1126.320, -89.084, 2185.330, -934.489, 110.916)
    AddZone("Las Colinas", 1994.330, -1100.820, -89.084, 2056.860, -920.815, 110.916)
    AddZone("Richman", 647.557, -954.662, -89.084, 768.694, -860.619, 110.916)
    AddZone("LVA Freight Depot", 1277.050, 1087.630, -89.084, 1375.600, 1203.280, 110.916)
    AddZone("Julius Thruway North", 1377.390, 2433.230, -89.084, 1534.560, 2507.230, 110.916)
    AddZone("Willowfield", 2201.820, -2095.000, -89.084, 2324.000, -1989.900, 110.916)
    AddZone("Julius Thruway North", 1704.590, 2342.830, -89.084, 1848.400, 2433.230, 110.916)
    AddZone("Temple", 1252.330, -1130.850, -89.084, 1378.330, -1026.330, 110.916)
    AddZone("Little Mexico", 1701.900, -1842.270, -89.084, 1812.620, -1722.260, 110.916)
    AddZone("Queens", -2411.220, 373.539, 0.000, -2253.540, 458.411, 200.000)
    AddZone("Las Venturas Airport", 1515.810, 1586.400, -12.500, 1729.950, 1714.560, 87.500)
    AddZone("Richman", 225.165, -1292.070, -89.084, 466.223, -1235.070, 110.916)
    AddZone("Temple", 1252.330, -1026.330, -89.084, 1391.050, -926.999, 110.916)
    AddZone("East Los Santos", 2266.260, -1494.030, -89.084, 2381.680, -1372.040, 110.916)
    AddZone("Julius Thruway East", 2623.180, 943.235, -89.084, 2749.900, 1055.960, 110.916)
    AddZone("Willowfield", 2541.700, -1941.400, -89.084, 2703.580, -1852.870, 110.916)
    AddZone("Las Colinas", 2056.860, -1126.320, -89.084, 2126.860, -920.815, 110.916)
    AddZone("Julius Thruway East", 2625.160, 2202.760, -89.084, 2685.160, 2442.550, 110.916)
    AddZone("Rodeo", 225.165, -1501.950, -89.084, 334.503, -1369.620, 110.916)
    AddZone("Las Brujas", -365.167, 2123.010, -3.0, -208.570, 2217.680, 200.000)
    AddZone("Julius Thruway East", 2536.430, 2442.550, -89.084, 2685.160, 2542.550, 110.916)
    AddZone("Rodeo", 334.503, -1406.050, -89.084, 466.223, -1292.070, 110.916)
    AddZone("Vinewood", 647.557, -1227.280, -89.084, 787.461, -1118.280, 110.916)
    AddZone("Rodeo", 422.680, -1684.650, -89.084, 558.099, -1570.200, 110.916)
    AddZone("Julius Thruway North", 2498.210, 2542.550, -89.084, 2685.160, 2626.550, 110.916)
    AddZone("Downtown Los Santos", 1724.760, -1430.870, -89.084, 1812.620, -1250.900, 110.916)
    AddZone("Rodeo", 225.165, -1684.650, -89.084, 312.803, -1501.950, 110.916)
    AddZone("Jefferson", 2056.860, -1449.670, -89.084, 2266.210, -1372.040, 110.916)
    AddZone("Hampton Barns", 603.035, 264.312, 0.000, 761.994, 366.572, 200.000)
    AddZone("Temple", 1096.470, -1130.840, -89.084, 1252.330, -1026.330, 110.916)
    AddZone("Kincaid Bridge", -1087.930, 855.370, -89.084, -961.950, 986.281, 110.916)
    AddZone("Verona Beach", 1046.150, -1722.260, -89.084, 1161.520, -1577.590, 110.916)
    AddZone("Commerce", 1323.900, -1722.260, -89.084, 1440.900, -1577.590, 110.916)
    AddZone("Mulholland", 1357.000, -926.999, -89.084, 1463.900, -768.027, 110.916)
    AddZone("Rodeo", 466.223, -1570.200, -89.084, 558.099, -1385.070, 110.916)
    AddZone("Mulholland", 911.802, -860.619, -89.084, 1096.470, -768.027, 110.916)
    AddZone("Mulholland", 768.694, -954.662, -89.084, 952.604, -860.619, 110.916)
    AddZone("Julius Thruway South", 2377.390, 788.894, -89.084, 2537.390, 897.901, 110.916)
    AddZone("Idlewood", 1812.620, -1852.870, -89.084, 1971.660, -1742.310, 110.916)
    AddZone("Ocean Docks", 2089.000, -2394.330, -89.084, 2201.820, -2235.840, 110.916)
    AddZone("Commerce", 1370.850, -1577.590, -89.084, 1463.900, -1384.950, 110.916)
    AddZone("Julius Thruway North", 2121.400, 2508.230, -89.084, 2237.400, 2663.170, 110.916)
    AddZone("Temple", 1096.470, -1026.330, -89.084, 1252.330, -910.170, 110.916)
    AddZone("Glen Park", 1812.620, -1449.670, -89.084, 1996.910, -1350.720, 110.916)
    AddZone("Easter Bay Airport", -1242.980, -50.096, 0.000, -1213.910, 578.396, 200.000)
    AddZone("Martin Bridge", -222.179, 293.324, 0.000, -122.126, 476.465, 200.000)
    AddZone("The Strip", 2106.700, 1863.230, -89.084, 2162.390, 2202.760, 110.916)
    AddZone("Willowfield", 2541.700, -2059.230, -89.084, 2703.580, -1941.400, 110.916)
    AddZone("Marina", 807.922, -1577.590, -89.084, 926.922, -1416.250, 110.916)
    AddZone("Las Venturas Airport", 1457.370, 1143.210, -89.084, 1777.400, 1203.280, 110.916)
    AddZone("Idlewood", 1812.620, -1742.310, -89.084, 1951.660, -1602.310, 110.916)
    AddZone("Esplanade East", -1580.010, 1025.980, -6.1, -1499.890, 1274.260, 200.000)
    AddZone("Downtown Los Santos", 1370.850, -1384.950, -89.084, 1463.900, -1170.870, 110.916)
    AddZone("The Mako Span", 1664.620, 401.750, 0.000, 1785.140, 567.203, 200.000)
    AddZone("Rodeo", 312.803, -1684.650, -89.084, 422.680, -1501.950, 110.916)
    AddZone("Pershing Square", 1440.900, -1722.260, -89.084, 1583.500, -1577.590, 110.916)
    AddZone("Mulholland", 687.802, -860.619, -89.084, 911.802, -768.027, 110.916)
    AddZone("Gant Bridge", -2741.070, 1490.470, -6.1, -2616.400, 1659.680, 200.000)
    AddZone("Las Colinas", 2185.330, -1154.590, -89.084, 2281.450, -934.489, 110.916)
    AddZone("Mulholland", 1169.130, -910.170, -89.084, 1318.130, -768.027, 110.916)
    AddZone("Julius Thruway North", 1938.800, 2508.230, -89.084, 2121.400, 2624.230, 110.916)
    AddZone("Commerce", 1667.960, -1577.590, -89.084, 1812.620, -1430.870, 110.916)
    AddZone("Rodeo", 72.648, -1544.170, -89.084, 225.165, -1404.970, 110.916)
    AddZone("Roca Escalante", 2536.430, 2202.760, -89.084, 2625.160, 2442.550, 110.916)
    AddZone("Rodeo", 72.648, -1684.650, -89.084, 225.165, -1544.170, 110.916)
    AddZone("Market", 952.663, -1310.210, -89.084, 1072.660, -1130.850, 110.916)
    AddZone("Las Colinas", 2632.740, -1135.040, -89.084, 2747.740, -945.035, 110.916)
    AddZone("Mulholland", 861.085, -674.885, -89.084, 1156.550, -600.896, 110.916)
    AddZone("King's", -2253.540, 373.539, -9.1, -1993.280, 458.411, 200.000)
    AddZone("Redsands East", 1848.400, 2342.830, -89.084, 2011.940, 2478.490, 110.916)
    AddZone("Downtown", -1580.010, 744.267, -6.1, -1499.890, 1025.980, 200.000)
    AddZone("Conference Center", 1046.150, -1804.210, -89.084, 1323.900, -1722.260, 110.916)
    AddZone("Richman", 647.557, -1118.280, -89.084, 787.461, -954.662, 110.916)
    AddZone("Ocean Flats", -2994.490, 277.411, -9.1, -2867.850, 458.411, 200.000)
    AddZone("Greenglass College", 964.391, 930.890, -89.084, 1166.530, 1044.690, 110.916)
    AddZone("Glen Park", 1812.620, -1100.820, -89.084, 1994.330, -973.380, 110.916)
    AddZone("LVA Freight Depot", 1375.600, 919.447, -89.084, 1457.370, 1203.280, 110.916)
    AddZone("Regular Tom", -405.770, 1712.860, -3.0, -276.719, 1892.750, 200.000)
    AddZone("Verona Beach", 1161.520, -1722.260, -89.084, 1323.900, -1577.590, 110.916)
    AddZone("East Los Santos", 2281.450, -1372.040, -89.084, 2381.680, -1135.040, 110.916)
    AddZone("Caligula's Palace", 2137.400, 1703.230, -89.084, 2437.390, 1783.230, 110.916)
    AddZone("Idlewood", 1951.660, -1742.310, -89.084, 2124.660, -1602.310, 110.916)
    AddZone("Pilgrim", 2624.400, 1383.230, -89.084, 2685.160, 1783.230, 110.916)
    AddZone("Idlewood", 2124.660, -1742.310, -89.084, 2222.560, -1494.030, 110.916)
    AddZone("Queens", -2533.040, 458.411, 0.000, -2329.310, 578.396, 200.000)
    AddZone("Downtown", -1871.720, 1176.420, -4.5, -1620.300, 1274.260, 200.000)
    AddZone("Commerce", 1583.500, -1722.260, -89.084, 1758.900, -1577.590, 110.916)
    AddZone("East Los Santos", 2381.680, -1454.350, -89.084, 2462.130, -1135.040, 110.916)
    AddZone("Marina", 647.712, -1577.590, -89.084, 807.922, -1416.250, 110.916)
    AddZone("Richman", 72.648, -1404.970, -89.084, 225.165, -1235.070, 110.916)
    AddZone("Vinewood", 647.712, -1416.250, -89.084, 787.461, -1227.280, 110.916)
    AddZone("East Los Santos", 2222.560, -1628.530, -89.084, 2421.030, -1494.030, 110.916)
    AddZone("Rodeo", 558.099, -1684.650, -89.084, 647.522, -1384.930, 110.916)
    AddZone("Easter Tunnel", -1709.710, -833.034, -1.5, -1446.010, -730.118, 200.000)
    AddZone("Rodeo", 466.223, -1385.070, -89.084, 647.522, -1235.070, 110.916)
    AddZone("Redsands East", 1817.390, 2202.760, -89.084, 2011.940, 2342.830, 110.916)
    AddZone("The Clown's Pocket", 2162.390, 1783.230, -89.084, 2437.390, 1883.230, 110.916)
    AddZone("Idlewood", 1971.660, -1852.870, -89.084, 2222.560, -1742.310, 110.916)
    AddZone("Montgomery Intersection", 1546.650, 208.164, 0.000, 1745.830, 347.457, 200.000)
    AddZone("Willowfield", 2089.000, -2235.840, -89.084, 2201.820, -1989.900, 110.916)
    AddZone("Temple", 952.663, -1130.840, -89.084, 1096.470, -937.184, 110.916)
    AddZone("Prickle Pine", 1848.400, 2553.490, -89.084, 1938.800, 2863.230, 110.916)
    AddZone("Los Santos International", 1400.970, -2669.260, -39.084, 2189.820, -2597.260, 60.916)
    AddZone("Garver Bridge", -1213.910, 950.022, -89.084, -1087.930, 1178.930, 110.916)
    AddZone("Garver Bridge", -1339.890, 828.129, -89.084, -1213.910, 1057.040, 110.916)
    AddZone("Kincaid Bridge", -1339.890, 599.218, -89.084, -1213.910, 828.129, 110.916)
    AddZone("Kincaid Bridge", -1213.910, 721.111, -89.084, -1087.930, 950.022, 110.916)
    AddZone("Verona Beach", 930.221, -2006.780, -89.084, 1073.220, -1804.210, 110.916)
    AddZone("Verdant Bluffs", 1073.220, -2006.780, -89.084, 1249.620, -1842.270, 110.916)
    AddZone("Vinewood", 787.461, -1130.840, -89.084, 952.604, -954.662, 110.916)
    AddZone("Vinewood", 787.461, -1310.210, -89.084, 952.663, -1130.840, 110.916)
    AddZone("Commerce", 1463.900, -1577.590, -89.084, 1667.960, -1430.870, 110.916)
    AddZone("Market", 787.461, -1416.250, -89.084, 1072.660, -1310.210, 110.916)
    AddZone("Rockshore West", 2377.390, 596.349, -89.084, 2537.390, 788.894, 110.916)
    AddZone("Julius Thruway North", 2237.400, 2542.550, -89.084, 2498.210, 2663.170, 110.916)
    AddZone("East Beach", 2632.830, -1668.130, -89.084, 2747.740, -1393.420, 110.916)
    AddZone("Fallow Bridge", 434.341, 366.572, 0.000, 603.035, 555.680, 200.000)
    AddZone("Willowfield", 2089.000, -1989.900, -89.084, 2324.000, -1852.870, 110.916)
    AddZone("Chinatown", -2274.170, 578.396, -7.6, -2078.670, 744.170, 200.000)
    AddZone("El Castillo del Diablo", -208.570, 2337.180, 0.000, 8.430, 2487.180, 200.000)
    AddZone("Ocean Docks", 2324.000, -2145.100, -89.084, 2703.580, -2059.230, 110.916)
    AddZone("Easter Bay Chemicals", -1132.820, -768.027, 0.000, -956.476, -578.118, 200.000)
    AddZone("The Visage", 1817.390, 1703.230, -89.084, 2027.400, 1863.230, 110.916)
    AddZone("Ocean Flats", -2994.490, -430.276, -1.2, -2831.890, -222.589, 200.000)
    AddZone("Richman", 321.356, -860.619, -89.084, 687.802, -768.027, 110.916)
    AddZone("Green Palms", 176.581, 1305.450, -3.0, 338.658, 1520.720, 200.000)
    AddZone("Richman", 321.356, -768.027, -89.084, 700.794, -674.885, 110.916)
    AddZone("Starfish Casino", 2162.390, 1883.230, -89.084, 2437.390, 2012.180, 110.916)
    AddZone("East Beach", 2747.740, -1668.130, -89.084, 2959.350, -1498.620, 110.916)
    AddZone("Jefferson", 2056.860, -1372.040, -89.084, 2281.450, -1210.740, 110.916)
    AddZone("Downtown Los Santos", 1463.900, -1290.870, -89.084, 1724.760, -1150.870, 110.916)
    AddZone("Downtown Los Santos", 1463.900, -1430.870, -89.084, 1724.760, -1290.870, 110.916)
    AddZone("Garver Bridge", -1499.890, 696.442, -179.615, -1339.890, 925.353, 20.385)
    AddZone("Julius Thruway South", 1457.390, 823.228, -89.084, 2377.390, 863.229, 110.916)
    AddZone("East Los Santos", 2421.030, -1628.530, -89.084, 2632.830, -1454.350, 110.916)
    AddZone("Greenglass College", 964.391, 1044.690, -89.084, 1197.390, 1203.220, 110.916)
    AddZone("Las Colinas", 2747.740, -1120.040, -89.084, 2959.350, -945.035, 110.916)
    AddZone("Mulholland", 737.573, -768.027, -89.084, 1142.290, -674.885, 110.916)
    AddZone("Ocean Docks", 2201.820, -2730.880, -89.084, 2324.000, -2418.330, 110.916)
    AddZone("East Los Santos", 2462.130, -1454.350, -89.084, 2581.730, -1135.040, 110.916)
    AddZone("Ganton", 2222.560, -1722.330, -89.084, 2632.830, -1628.530, 110.916)
    AddZone("Avispa Country Club", -2831.890, -430.276, -6.1, -2646.400, -222.589, 200.000)
    AddZone("Willowfield", 1970.620, -2179.250, -89.084, 2089.000, -1852.870, 110.916)
    AddZone("Esplanade North", -1982.320, 1274.260, -4.5, -1524.240, 1358.900, 200.000)
    AddZone("The High Roller", 1817.390, 1283.230, -89.084, 2027.390, 1469.230, 110.916)
    AddZone("Ocean Docks", 2201.820, -2418.330, -89.084, 2324.000, -2095.000, 110.916)
    AddZone("Last Dime Motel", 1823.080, 596.349, -89.084, 1997.220, 823.228, 110.916)
    AddZone("Bayside Marina", -2353.170, 2275.790, 0.000, -2153.170, 2475.790, 200.000)
    AddZone("King's", -2329.310, 458.411, -7.6, -1993.280, 578.396, 200.000)
    AddZone("El Corona", 1692.620, -2179.250, -89.084, 1812.620, -1842.270, 110.916)
    AddZone("Blackfield Chapel", 1375.600, 596.349, -89.084, 1558.090, 823.228, 110.916)
    AddZone("The Pink Swan", 1817.390, 1083.230, -89.084, 2027.390, 1283.230, 110.916)
    AddZone("Julius Thruway West", 1197.390, 1163.390, -89.084, 1236.630, 2243.230, 110.916)
    AddZone("Los Flores", 2581.730, -1393.420, -89.084, 2747.740, -1135.040, 110.916)
    AddZone("The Visage", 1817.390, 1863.230, -89.084, 2106.700, 2011.830, 110.916)
    AddZone("Prickle Pine", 1938.800, 2624.230, -89.084, 2121.400, 2861.550, 110.916)
    AddZone("Verona Beach", 851.449, -1804.210, -89.084, 1046.150, -1577.590, 110.916)
    AddZone("Robada Intersection", -1119.010, 1178.930, -89.084, -862.025, 1351.450, 110.916)
    AddZone("Linden Side", 2749.900, 943.235, -89.084, 2923.390, 1198.990, 110.916)
    AddZone("Ocean Docks", 2703.580, -2302.330, -89.084, 2959.350, -2126.900, 110.916)
    AddZone("Willowfield", 2324.000, -2059.230, -89.084, 2541.700, -1852.870, 110.916)
    AddZone("King's", -2411.220, 265.243, -9.1, -1993.280, 373.539, 200.000)
    AddZone("Commerce", 1323.900, -1842.270, -89.084, 1701.900, -1722.260, 110.916)
    AddZone("Mulholland", 1269.130, -768.027, -89.084, 1414.070, -452.425, 110.916)
    AddZone("Marina", 647.712, -1804.210, -89.084, 851.449, -1577.590, 110.916)
    AddZone("Battery Point", -2741.070, 1268.410, -4.5, -2533.040, 1490.470, 200.000)
    AddZone("The Four Dragons Casino", 1817.390, 863.232, -89.084, 2027.390, 1083.230, 110.916)
    AddZone("Blackfield", 964.391, 1203.220, -89.084, 1197.390, 1403.220, 110.916)
    AddZone("Julius Thruway North", 1534.560, 2433.230, -89.084, 1848.400, 2583.230, 110.916)
    AddZone("Yellow Bell Gol Course", 1117.400, 2723.230, -89.084, 1457.460, 2863.230, 110.916)
    AddZone("Idlewood", 1812.620, -1602.310, -89.084, 2124.660, -1449.670, 110.916)
    AddZone("Redsands West", 1297.470, 2142.860, -89.084, 1777.390, 2243.230, 110.916)
    AddZone("Doherty", -2270.040, -324.114, -1.2, -1794.920, -222.589, 200.000)
    AddZone("Hilltop Farm", 967.383, -450.390, -3.0, 1176.780, -217.900, 200.000)
    AddZone("Las Barrancas", -926.130, 1398.730, -3.0, -719.234, 1634.690, 200.000)
    AddZone("Pirates in Men's Pants", 1817.390, 1469.230, -89.084, 2027.400, 1703.230, 110.916)
    AddZone("City Hall", -2867.850, 277.411, -9.1, -2593.440, 458.411, 200.000)
    AddZone("Avispa Country Club", -2646.400, -355.493, 0.000, -2270.040, -222.589, 200.000)
    AddZone("The Strip", 2027.400, 863.229, -89.084, 2087.390, 1703.230, 110.916)
    AddZone("Hashbury", -2593.440, -222.589, -1.0, -2411.220, 54.722, 200.000)
    AddZone("Los Santos International", 1852.000, -2394.330, -89.084, 2089.000, -2179.250, 110.916)
    AddZone("Whitewood Estates", 1098.310, 1726.220, -89.084, 1197.390, 2243.230, 110.916)
    AddZone("Sherman Reservoir", -789.737, 1659.680, -89.084, -599.505, 1929.410, 110.916)
    AddZone("El Corona", 1812.620, -2179.250, -89.084, 1970.620, -1852.870, 110.916)
    AddZone("Downtown", -1700.010, 744.267, -6.1, -1580.010, 1176.520, 200.000)
    AddZone("Foster Valley", -2178.690, -1250.970, 0.000, -1794.920, -1115.580, 200.000)
    AddZone("Las Payasadas", -354.332, 2580.360, 2.0, -133.625, 2816.820, 200.000)
    AddZone("Valle Ocultado", -936.668, 2611.440, 2.0, -715.961, 2847.900, 200.000)
    AddZone("Blackfield Intersection", 1166.530, 795.010, -89.084, 1375.600, 1044.690, 110.916)
    AddZone("Ganton", 2222.560, -1852.870, -89.084, 2632.830, -1722.330, 110.916)
    AddZone("Easter Bay Airport", -1213.910, -730.118, 0.000, -1132.820, -50.096, 200.000)
    AddZone("Redsands East", 1817.390, 2011.830, -89.084, 2106.700, 2202.760, 110.916)
    AddZone("Esplanade East", -1499.890, 578.396, -79.615, -1339.890, 1274.260, 20.385)
    AddZone("Caligula's Palace", 2087.390, 1543.230, -89.084, 2437.390, 1703.230, 110.916)
    AddZone("Royal Casino", 2087.390, 1383.230, -89.084, 2437.390, 1543.230, 110.916)
    AddZone("Richman", 72.648, -1235.070, -89.084, 321.356, -1008.150, 110.916)
    AddZone("Starfish Casino", 2437.390, 1783.230, -89.084, 2685.160, 2012.180, 110.916)
    AddZone("Mulholland", 1281.130, -452.425, -89.084, 1641.130, -290.913, 110.916)
    AddZone("Downtown", -1982.320, 744.170, -6.1, -1871.720, 1274.260, 200.000)
    AddZone("Hankypanky Point", 2576.920, 62.158, 0.000, 2759.250, 385.503, 200.000)
    AddZone("K.A.C.C. Military Fuels", 2498.210, 2626.550, -89.084, 2749.900, 2861.550, 110.916)
    AddZone("Harry Gold Parkway", 1777.390, 863.232, -89.084, 1817.390, 2342.830, 110.916)
    AddZone("Bayside Tunnel", -2290.190, 2548.290, -89.084, -1950.190, 2723.290, 110.916)
    AddZone("Ocean Docks", 2324.000, -2302.330, -89.084, 2703.580, -2145.100, 110.916)
    AddZone("Richman", 321.356, -1044.070, -89.084, 647.557, -860.619, 110.916)
    AddZone("Randolph Industrial Estate", 1558.090, 596.349, -89.084, 1823.080, 823.235, 110.916)
    AddZone("East Beach", 2632.830, -1852.870, -89.084, 2959.350, -1668.130, 110.916)
    AddZone("Flint Water", -314.426, -753.874, -89.084, -106.339, -463.073, 110.916)
    AddZone("Blueberry", 19.607, -404.136, 3.8, 349.607, -220.137, 200.000)
    AddZone("Linden Station", 2749.900, 1198.990, -89.084, 2923.390, 1548.990, 110.916)
    AddZone("Glen Park", 1812.620, -1350.720, -89.084, 2056.860, -1100.820, 110.916)
    AddZone("Downtown", -1993.280, 265.243, -9.1, -1794.920, 578.396, 200.000)
    AddZone("Redsands West", 1377.390, 2243.230, -89.084, 1704.590, 2433.230, 110.916)
    AddZone("Richman", 321.356, -1235.070, -89.084, 647.522, -1044.070, 110.916)
    AddZone("Gant Bridge", -2741.450, 1659.680, -6.1, -2616.400, 2175.150, 200.000)
    AddZone("Lil' Probe Inn", -90.218, 1286.850, -3.0, 153.859, 1554.120, 200.000)
    AddZone("Flint Intersection", -187.700, -1596.760, -89.084, 17.063, -1276.600, 110.916)
    AddZone("Las Colinas", 2281.450, -1135.040, -89.084, 2632.740, -945.035, 110.916)
    AddZone("Sobell Rail Yards", 2749.900, 1548.990, -89.084, 2923.390, 1937.250, 110.916)
    AddZone("The Emerald Isle", 2011.940, 2202.760, -89.084, 2237.400, 2508.230, 110.916)
    AddZone("El Castillo del Diablo", -208.570, 2123.010, -7.6, 114.033, 2337.180, 200.000)
    AddZone("Santa Flora", -2741.070, 458.411, -7.6, -2533.040, 793.411, 200.000)
    AddZone("Playa del Seville", 2703.580, -2126.900, -89.084, 2959.350, -1852.870, 110.916)
    AddZone("Market", 926.922, -1577.590, -89.084, 1370.850, -1416.250, 110.916)
    AddZone("Queens", -2593.440, 54.722, 0.000, -2411.220, 458.411, 200.000)
    AddZone("Pilson Intersection", 1098.390, 2243.230, -89.084, 1377.390, 2507.230, 110.916)
    AddZone("Spinybed", 2121.400, 2663.170, -89.084, 2498.210, 2861.550, 110.916)
    AddZone("Pilgrim", 2437.390, 1383.230, -89.084, 2624.400, 1783.230, 110.916)
    AddZone("Blackfield", 964.391, 1403.220, -89.084, 1197.390, 1726.220, 110.916)
    AddZone("'The Big Ear'", -410.020, 1403.340, -3.0, -137.969, 1681.230, 200.000)
    AddZone("Dillimore", 580.794, -674.885, -9.5, 861.085, -404.790, 200.000)
    AddZone("El Quebrados", -1645.230, 2498.520, 0.000, -1372.140, 2777.850, 200.000)
    AddZone("Esplanade North", -2533.040, 1358.900, -4.5, -1996.660, 1501.210, 200.000)
    AddZone("Easter Bay Airport", -1499.890, -50.096, -1.0, -1242.980, 249.904, 200.000)
    AddZone("Fisher's Lagoon", 1916.990, -233.323, -100.000, 2131.720, 13.800, 200.000)
    AddZone("Mulholland", 1414.070, -768.027, -89.084, 1667.610, -452.425, 110.916)
    AddZone("East Beach", 2747.740, -1498.620, -89.084, 2959.350, -1120.040, 110.916)
    AddZone("San Andreas Sound", 2450.390, 385.503, -100.000, 2759.250, 562.349, 200.000)
    AddZone("Shady Creeks", -2030.120, -2174.890, -6.1, -1820.640, -1771.660, 200.000)
    AddZone("Market", 1072.660, -1416.250, -89.084, 1370.850, -1130.850, 110.916)
    AddZone("Rockshore West", 1997.220, 596.349, -89.084, 2377.390, 823.228, 110.916)
    AddZone("Prickle Pine", 1534.560, 2583.230, -89.084, 1848.400, 2863.230, 110.916)
    AddZone("Easter Basin", -1794.920, -50.096, -1.04, -1499.890, 249.904, 200.000)
    AddZone("Leafy Hollow", -1166.970, -1856.030, 0.000, -815.624, -1602.070, 200.000)
    AddZone("LVA Freight Depot", 1457.390, 863.229, -89.084, 1777.400, 1143.210, 110.916)
    AddZone("Prickle Pine", 1117.400, 2507.230, -89.084, 1534.560, 2723.230, 110.916)
    AddZone("Blueberry", 104.534, -220.137, 2.3, 349.607, 152.236, 200.000)
    AddZone("El Castillo del Diablo", -464.515, 2217.680, 0.000, -208.570, 2580.360, 200.000)
    AddZone("Downtown", -2078.670, 578.396, -7.6, -1499.890, 744.267, 200.000)
    AddZone("Rockshore East", 2537.390, 676.549, -89.084, 2902.350, 943.235, 110.916)
    AddZone("San Fierro Bay", -2616.400, 1501.210, -3.0, -1996.660, 1659.680, 200.000)
    AddZone("Paradiso", -2741.070, 793.411, -6.1, -2533.040, 1268.410, 200.000)
    AddZone("The Camel's Toe", 2087.390, 1203.230, -89.084, 2640.400, 1383.230, 110.916)
    AddZone("Old Venturas Strip", 2162.390, 2012.180, -89.084, 2685.160, 2202.760, 110.916)
    AddZone("Juniper Hill", -2533.040, 578.396, -7.6, -2274.170, 968.369, 200.000)
    AddZone("Juniper Hollow", -2533.040, 968.369, -6.1, -2274.170, 1358.900, 200.000)
    AddZone("Roca Escalante", 2237.400, 2202.760, -89.084, 2536.430, 2542.550, 110.916)
    AddZone("Julius Thruway East", 2685.160, 1055.960, -89.084, 2749.900, 2626.550, 110.916)
    AddZone("Verona Beach", 647.712, -2173.290, -89.084, 930.221, -1804.210, 110.916)
    AddZone("Foster Valley", -2178.690, -599.884, -1.2, -1794.920, -324.114, 200.000)
    AddZone("Arco del Oeste", -901.129, 2221.860, 0.000, -592.090, 2571.970, 200.000)
    AddZone("Fallen Tree", -792.254, -698.555, -5.3, -452.404, -380.043, 200.000)
    AddZone("The Farm", -1209.670, -1317.100, 114.981, -908.161, -787.391, 251.981)
    AddZone("The Sherman Dam", -968.772, 1929.410, -3.0, -481.126, 2155.260, 200.000)
    AddZone("Esplanade North", -1996.660, 1358.900, -4.5, -1524.240, 1592.510, 200.000)
    AddZone("Financial", -1871.720, 744.170, -6.1, -1701.300, 1176.420, 300.000)
    AddZone("Garcia", -2411.220, -222.589, -1.14, -2173.040, 265.243, 200.000)
    AddZone("Montgomery", 1119.510, 119.526, -3.0, 1451.400, 493.323, 200.000)
    AddZone("Creek", 2749.900, 1937.250, -89.084, 2921.620, 2669.790, 110.916)
    AddZone("Los Santos International", 1249.620, -2394.330, -89.084, 1852.000, -2179.250, 110.916)
    AddZone("Santa Maria Beach", 72.648, -2173.290, -89.084, 342.648, -1684.650, 110.916)
    AddZone("Mulholland Intersection", 1463.900, -1150.870, -89.084, 1812.620, -768.027, 110.916)
    AddZone("Angel Pine", -2324.940, -2584.290, -6.1, -1964.220, -2212.110, 200.000)
    AddZone("Verdant Meadows", 37.032, 2337.180, -3.0, 435.988, 2677.900, 200.000)
    AddZone("Octane Springs", 338.658, 1228.510, 0.000, 664.308, 1655.050, 200.000)
    AddZone("Come-A-Lot", 2087.390, 943.235, -89.084, 2623.180, 1203.230, 110.916)
    AddZone("Redsands West", 1236.630, 1883.110, -89.084, 1777.390, 2142.860, 110.916)
    AddZone("Santa Maria Beach", 342.648, -2173.290, -89.084, 647.712, -1684.650, 110.916)
    AddZone("Verdant Bluffs", 1249.620, -2179.250, -89.084, 1692.620, -1842.270, 110.916)
    AddZone("Las Venturas Airport", 1236.630, 1203.280, -89.084, 1457.370, 1883.110, 110.916)
    AddZone("Flint Range", -594.191, -1648.550, 0.000, -187.700, -1276.600, 200.000)
    AddZone("Verdant Bluffs", 930.221, -2488.420, -89.084, 1249.620, -2006.780, 110.916)
    AddZone("Palomino Creek", 2160.220, -149.004, 0.000, 2576.920, 228.322, 200.000)
    AddZone("Ocean Docks", 2373.770, -2697.090, -89.084, 2809.220, -2330.460, 110.916)
    AddZone("Easter Bay Airport", -1213.910, -50.096, -4.5, -947.980, 578.396, 200.000)
    AddZone("Whitewood Estates", 883.308, 1726.220, -89.084, 1098.310, 2507.230, 110.916)
    AddZone("Calton Heights", -2274.170, 744.170, -6.1, -1982.320, 1358.900, 200.000)
    AddZone("Easter Basin", -1794.920, 249.904, -9.1, -1242.980, 578.396, 200.000)
    AddZone("Los Santos Inlet", -321.744, -2224.430, -89.084, 44.615, -1724.430, 110.916)
    AddZone("Doherty", -2173.040, -222.589, -1.0, -1794.920, 265.243, 200.000)
    AddZone("Mount Chiliad", -2178.690, -2189.910, -47.917, -2030.120, -1771.660, 576.083)
    AddZone("Fort Carson", -376.233, 826.326, -3.0, 123.717, 1220.440, 200.000)
    AddZone("Foster Valley", -2178.690, -1115.580, 0.000, -1794.920, -599.884, 200.000)
    AddZone("Ocean Flats", -2994.490, -222.589, -1.0, -2593.440, 277.411, 200.000)
    AddZone("Fern Ridge", 508.189, -139.259, 0.000, 1306.660, 119.526, 200.000)
    AddZone("Bayside", -2741.070, 2175.150, 0.000, -2353.170, 2722.790, 200.000)
    AddZone("Las Venturas Airport", 1457.370, 1203.280, -89.084, 1777.390, 1883.110, 110.916)
    AddZone("Blueberry Acres", -319.676, -220.137, 0.000, 104.534, 293.324, 200.000)
    AddZone("Palisades", -2994.490, 458.411, -6.1, -2741.070, 1339.610, 200.000)
    AddZone("North Rock", 2285.370, -768.027, 0.000, 2770.590, -269.740, 200.000)
    AddZone("Hunter Quarry", 337.244, 710.840, -115.239, 860.554, 1031.710, 203.761)
    AddZone("Los Santos International", 1382.730, -2730.880, -89.084, 2201.820, -2394.330, 110.916)
    AddZone("Missionary Hill", -2994.490, -811.276, 0.000, -2178.690, -430.276, 200.000)
    AddZone("San Fierro Bay", -2616.400, 1659.680, -3.0, -1996.660, 2175.150, 200.000)
    AddZone("Restricted Area", -91.586, 1655.050, -50.000, 421.234, 2123.010, 250.000)
    AddZone("Mount Chiliad", -2997.470, -1115.580, -47.917, -2178.690, -971.913, 576.083)
    AddZone("Mount Chiliad", -2178.690, -1771.660, -47.917, -1936.120, -1250.970, 576.083)
    AddZone("Easter Bay Airport", -1794.920, -730.118, -3.0, -1213.910, -50.096, 200.000)
    AddZone("The Panopticon", -947.980, -304.320, -1.1, -319.676, 327.071, 200.000)
    AddZone("Shady Creeks", -1820.640, -2643.680, -8.0, -1226.780, -1771.660, 200.000)
    AddZone("Back o Beyond", -1166.970, -2641.190, 0.000, -321.744, -1856.030, 200.000)
    AddZone("Mount Chiliad", -2994.490, -2189.910, -47.917, -2178.690, -1115.580, 576.083)
    AddZone("Tierra Robada", -1213.910, 596.349, -242.990, -480.539, 1659.680, 900.000)
    AddZone("Flint County", -1213.910, -2892.970, -242.990, 44.615, -768.027, 900.000)
    AddZone("Whetstone", -2997.470, -2892.970, -242.990, -1213.910, -1115.580, 900.000)
    AddZone("Bone County", -480.539, 596.349, -242.990, 869.461, 2993.870, 900.000)
    AddZone("Tierra Robada", -2997.470, 1659.680, -242.990, -480.539, 2993.870, 900.000)
    AddZone("San Fierro", -2997.470, -1115.580, -242.990, -1213.910, 1659.680, 900.000)
    AddZone("Las Venturas", 869.461, 596.349, -242.990, 2997.060, 2993.870, 900.000)
    AddZone("Red County", -1213.910, -768.027, -242.990, 2997.060, 596.349, 900.000)
    AddZone("Los Santos", 44.615, -2892.970, -242.990, 2997.060, -768.027, 900.000)
}

calculateZone(posX, posY, posZ) {
    
    if ( bInitZaC == 0 )
    {
        initZonesAndCities()
        bInitZaC := 1
    }
        
    Loop % nZone-1
    {
        if (posX >= zone%A_Index%_x1) && (posY >= zone%A_Index%_y1) && (posZ >= zone%A_Index%_z1) && (posX <= zone%A_Index%_x2) && (posY <= zone%A_Index%_y2) && (posZ <= zone%A_Index%_z2)
        {
            ErrorLevel := ERROR_OK
            return zone%A_Index%_name
        }
    }
    
    ErrorLevel := ERROR_ZONE_NOT_FOUND
    return "Unknown"
}

calculateCity(posX, posY, posZ) {
    
    if ( bInitZaC == 0 )
    {
        initZonesAndCities()
        bInitZaC := 1
    }
    smallestCity := "Unknown"
    currentCitySize := 0
    smallestCitySize := 0
    
    Loop % nCity-1
    {
        if (posX >= city%A_Index%_x1) && (posY >= city%A_Index%_y1) && (posZ >= city%A_Index%_z1) && (posX <= city%A_Index%_x2) && (posY <= city%A_Index%_y2) && (posZ <= city%A_Index%_z2)
        {
            currentCitySize := ((city%A_Index%_x2 - city%A_Index%_x1) * (city%A_Index%_y2 - city%A_Index%_y1) * (city%A_Index%_z2 - city%A_Index%_z1))
            if (smallestCity == "Unknown") || (currentCitySize < smallestCitySize)
            {
                smallestCity := city%A_Index%_name
                smallestCitySize := currentCitySize
            }
        }
    }
    
    if(smallestCity == "Unknown") {
        ErrorLevel := ERROR_CITY_NOT_FOUND
    } else {
        ErrorLevel := ERROR_OK
    }
    return smallestCity
}

/*
;do not work?
getCurrentZonecode() {
    if(!checkHandles())
        return ""
    
    return readString(hGTA, ADDR_ZONECODE, 5)
}
*/

AddZone(sName, x1, y1, z1, x2, y2, z2) {
    global
    zone%nZone%_name := sName
    zone%nZone%_x1 := x1
    zone%nZone%_y1 := y1
    zone%nZone%_z1 := z1
    zone%nZone%_x2 := x2
    zone%nZone%_y2 := y2
    zone%nZone%_z2 := z2
    nZone := nZone + 1
}

AddCity(sName, x1, y1, z1, x2, y2, z2) {
    global
    city%nCity%_name := sName
    city%nCity%_x1 := x1
    city%nCity%_y1 := y1
    city%nCity%_z1 := z1
    city%nCity%_x2 := x2
    city%nCity%_y2 := y2
    city%nCity%_z2 := z2
    nCity := nCity + 1
}

IsPlayerInRangeOfPoint(_posX, _posY, _posZ, _posRadius)
{
	GetPlayerPos(posX, posY, posZ)
	X := posX -_posX
	Y := posY -_posY
	Z := posZ -_posZ
	if(((X < _posRadius) && (X > -_posRadius)) && ((Y < _posRadius) && (Y > -_posRadius)) && ((Z < _posRadius) && (Z > -_posRadius)))
		return TRUE
	return FALSE
}
 
IsPlayerInRangeOfPoint2D(_posX, _posY, _posRadius)
{
 
	GetPlayerPos(posX, posY, posZ)
	X := posX - _posX
	Y := posY - _posY
	if(((X < _posRadius) && (X > -_posRadius)) && ((Y < _posRadius) && (Y > -_posRadius)))
		return TRUE
	return FALSE
}

getPlayerZone()
{
	aktPos := getCoordinates()
	return calculateZone(aktPos[1], aktPos[2], aktPos[3])
}

getPlayerCity()
{
	aktPos := getCoordinates()
	return calculateCity(aktPos[1], aktPos[2], aktPos[3])
}
AntiCrash(){
    If(!checkHandles())
        return false

    cReport := ADDR_SAMP_CRASHREPORT
    writeMemory(hGTA, dwSAMP + cReport, 0x90909090, 4)
    cReport += 0x4
    writeMemory(hGTA, dwSAMP + cReport, 0x90, 1)
    cReport += 0x9
    writeMemory(hGTA, dwSAMP + cReport, 0x90909090, 4)
    cReport += 0x4
    writeMemory(hGTA, dwSAMP + cReport, 0x90, 1)
}

writeMemory(hProcess,address,writevalue,length=4, datatype="int") {
  if(!hProcess) {
    ErrorLevel := ERROR_INVALID_HANDLE
    return false
  }

  VarSetCapacity(finalvalue,length, 0)
  NumPut(writevalue,finalvalue,0,datatype)
  dwRet :=  DllCall(  "WriteProcessMemory"
              ,"Uint",hProcess
              ,"Uint",address
              ,"Uint",&finalvalue
              ,"Uint",length
              ,"Uint",0)
  if(dwRet == 0) {
    ErrorLevel := ERROR_WRITE_MEMORY
    return false
  }

  ErrorLevel := ERROR_OK
  return true
}
; ##### Sonstiges #####
checkHandles() {
    if(iRefreshHandles+500>A_TickCount)
        return true
    iRefreshHandles:=A_TickCount
    if(!refreshGTA() || !refreshSAMP() || !refreshMemory()) {
        return false
    } else {
        return true
    }
    
    return true
}

; internal stuff
refreshGTA() {
    newPID := getPID("GTA:SA:MP")
    if(!newPID) {                            ; GTA not found
        if(hGTA) {                            ; open handle
            virtualFreeEx(hGTA, pMemory, 0, 0x8000)
            closeProcess(hGTA)
            hGTA := 0x0
        }
        dwGTAPID := 0
        hGTA := 0x0
        dwSAMP := 0x0
        pMemory := 0x0
        return false
    }
    
    if(!hGTA || (dwGTAPID != newPID)) {        ; changed PID, closed handle
        hGTA := openProcess(newPID)
        if(ErrorLevel) {                    ; openProcess fail
            dwGTAPID := 0
            hGTA := 0x0
            dwSAMP := 0x0
            pMemory := 0x0
            return false
        }
        dwGTAPID := newPID
        dwSAMP := 0x0
        pMemory := 0x0
        return true
    }
    return true
}

; internal stuff
refreshSAMP() {
    if(dwSAMP)
        return true
    
    dwSAMP := getModuleBaseAddress("samp.dll", hGTA)
    if(!dwSAMP)
        return false
    
    return true
}

; internal stuff
refreshMemory() {
    if(!pMemory) {
        pMemory     := virtualAllocEx(hGTA, 6144, 0x1000 | 0x2000, 0x40)
        if(ErrorLevel) {
            pMemory := 0x0
            return false
        }
        pParam1     := pMemory
        pParam2     := pMemory + 1024
        pParam3     := pMemory + 2048
        pParam4     := pMemory + 3072
        pParam5     := pMemory + 4096
        pInjectFunc := pMemory + 5120
    }
    return true
}

; internal stuff
getPID(szWindow) {
    local dwPID := 0
    WinGet, dwPID, PID, %szWindow%
    return dwPID
}

; internal stuff
openProcess(dwPID, dwRights = 0x1F0FFF) {
    hProcess := DllCall("OpenProcess"
                        , "UInt", dwRights
                        , "int",  0
                        , "UInt", dwPID
                        , "Uint")
    if(hProcess == 0) {
        ErrorLevel := ERROR_OPEN_PROCESS
        return 0
    }
    
    ErrorLevel := ERROR_OK
    return hProcess
}

; internal stuff
closeProcess(hProcess) {
    if(hProcess == 0) {
        ErrorLevel := ERROR_INVALID_HANDLE
        return 0
    }
    
    dwRet := DllCall(    "CloseHandle"
                        , "Uint", hProcess
                        , "UInt")
    ErrorLevel := ERROR_OK
}

; internal stuff
getModuleBaseAddress(sModule, hProcess) {
    if(!sModule) {
        ErrorLevel := ERROR_MODULE_NOT_FOUND
        return 0
    }
    
    if(!hProcess) {
        ErrorLevel := ERROR_INVALID_HANDLE
        return 0
    }
    
    dwSize = 1024*4                    ; 1024 * sizeof(HMODULE = 4)
    VarSetCapacity(hMods, dwSize)    
    VarSetCapacity(cbNeeded, 4)        ; DWORD = 4
    dwRet := DllCall(    "Psapi.dll\EnumProcessModules"
                        , "UInt", hProcess
                        , "UInt", &hMods
                        , "UInt", dwSize
                        , "UInt*", cbNeeded
                        , "UInt")
    if(dwRet == 0) {
        ErrorLevel := ERROR_ENUM_PROCESS_MODULES
        return 0
    }
    
    dwMods := cbNeeded / 4            ; cbNeeded / sizeof(HMDOULE = 4)
    i := 0
    VarSetCapacity(hModule, 4)        ; HMODULE = 4
    VarSetCapacity(sCurModule, 260)    ; MAX_PATH = 260
    while(i < dwMods) {
        hModule := NumGet(hMods, i*4)
        DllCall("Psapi.dll\GetModuleFileNameEx"
                , "UInt", hProcess
                , "UInt", hModule
                , "Str", sCurModule
                , "UInt", 260)
        SplitPath, sCurModule, sFilename
        if(sModule == sFilename) {
            ErrorLevel := ERROR_OK
            return hModule
        }
        i := i + 1
    }
    
    ErrorLevel := ERROR_MODULE_NOT_FOUND
    return 0
}

; internal stuff
readString(hProcess, dwAddress, dwLen) {
    if(!hProcess) {
        ErrorLevel := ERROR_INVALID_HANDLE
        return 0
    }
    
    VarSetCapacity(sRead, dwLen)
    dwRet := DllCall(    "ReadProcessMemory"
                        , "UInt", hProcess
                        , "UInt", dwAddress
                        , "Str", sRead
                        , "UInt", dwLen
                        , "UInt*", 0
                        , "UInt")
    if(dwRet == 0) {
        ErrorLevel := ERROR_READ_MEMORY
        return 0
    }
    
    ErrorLevel := ERROR_OK
    if A_IsUnicode
        return __ansiToUnicode(sRead)
    return sRead
}

; internal stuff
readFloat(hProcess, dwAddress) {
    if(!hProcess) {
        ErrorLevel := ERROR_INVALID_HANDLE
        return 0
    }
    
    VarSetCapacity(dwRead, 4)    ; float = 4
    dwRet := DllCall(    "ReadProcessMemory"
                        , "UInt",  hProcess
                        , "UInt",  dwAddress
                        , "Str",   dwRead
                        , "UInt",  4
                        , "UInt*", 0
                        , "UInt")
    if(dwRet == 0) {
        ErrorLevel := ERROR_READ_MEMORY
        return 0
    }
    
    ErrorLevel := ERROR_OK
    return NumGet(dwRead, 0, "Float")
}

; internal stuff
readDWORD(hProcess, dwAddress) {
    if(!hProcess) {
        ErrorLevel := ERROR_INVALID_HANDLE
        return 0
    }
    
    VarSetCapacity(dwRead, 4)    ; DWORD = 4
    dwRet := DllCall(    "ReadProcessMemory"
                        , "UInt",  hProcess
                        , "UInt",  dwAddress
                        , "Str",   dwRead
                        , "UInt",  4
                        , "UInt*", 0)
    if(dwRet == 0) {
        ErrorLevel := ERROR_READ_MEMORY
        return 0
    }
    
    ErrorLevel := ERROR_OK
    return NumGet(dwRead, 0, "UInt")
}

; internal stuff
readMem(hProcess, dwAddress, dwLen=4, type="UInt") {
    if(!hProcess) {
        ErrorLevel := ERROR_INVALID_HANDLE
        return 0
    }
    
    VarSetCapacity(dwRead, dwLen)
    dwRet := DllCall(    "ReadProcessMemory"
                        , "UInt",  hProcess
                        , "UInt",  dwAddress
                        , "Str",   dwRead
                        , "UInt",  dwLen
                        , "UInt*", 0)
    if(dwRet == 0) {
        ErrorLevel := ERROR_READ_MEMORY
        return 0
    }
    
    ErrorLevel := ERROR_OK
    return NumGet(dwRead, 0, type)
}

; internal stuff
writeString(hProcess, dwAddress, wString) {
    if(!hProcess) {
        ErrorLevel := ERROR_INVALID_HANDLE
        return false
    }
    
    sString := wString
    if A_IsUnicode
        sString := __unicodeToAnsi(wString)
    
    dwRet := DllCall(    "WriteProcessMemory"
                        , "UInt", hProcess
                        , "UInt", dwAddress
                        , "Str", sString
                        , "UInt", StrLen(wString) + 1
                        , "UInt", 0
                        , "UInt")
    if(dwRet == 0) {
        ErrorLEvel := ERROR_WRITE_MEMORY
        return false
    }
    
    ErrorLevel := ERROR_OK
    return true
}

; internal stuff
writeRaw(hProcess, dwAddress, pBuffer, dwLen) {
    if(!hProcess) {
        ErrorLevel := ERROR_INVALID_HANDLE
        return false
    }
    
    dwRet := DllCall(    "WriteProcessMemory"
                        , "UInt", hProcess
                        , "UInt", dwAddress
                        , "UInt", pBuffer
                        , "UInt", dwLen
                        , "UInt", 0
                        , "UInt")
    if(dwRet == 0) {
        ErrorLEvel := ERROR_WRITE_MEMORY
        return false
    }
    
    ErrorLevel := ERROR_OK
    return true
}

; internal stuff
Memory_ReadByte(process_handle, address) {
	VarSetCapacity(value, 1, 0)
	DllCall("ReadProcessMemory", "UInt", process_handle, "UInt", address, "Str", value, "UInt", 1, "UInt *", 0)
	return, NumGet(value, 0, "Byte")
}

; internal stuff
callWithParams(hProcess, dwFunc, aParams, bCleanupStack = true) {
    if(!hProcess) {
        ErrorLevel := ERROR_INVALID_HANDLE
        return false
    }
    validParams := 0
    
    i := aParams.MaxIndex()
    
    ;         i * PUSH + CALL + RETN
    dwLen := i * 5    + 5    + 1
    if(bCleanupStack)
        dwLen += 3
    VarSetCapacity(injectData, i * 5    + 5       + 3       + 1, 0)
    
    i_ := 1
    while(i > 0) {
        if(aParams[i][1] != "") {
            dwMemAddress := 0x0
            if(aParams[i][1] == "p") {
                dwMemAddress := aParams[i][2]
            } else if(aParams[i][1] == "s") {
                if(i_>3)
                    return false
                dwMemAddress := pParam%i_%
                writeString(hProcess, dwMemAddress, aParams[i][2])
                if(ErrorLevel)
                    return false
                i_ += 1
            } else if(aParams[i][1] == "i") {
                dwMemAddress := aParams[i][2]
            } else {
                return false
            }
            NumPut(0x68, injectData, validParams * 5, "UChar")
            NumPut(dwMemAddress, injectData, validParams * 5 + 1, "UInt")
            validParams += 1
        }
        i -= 1
    }
    
    offset := dwFunc - ( pInjectFunc + validParams * 5 + 5 )
    NumPut(0xE8, injectData, validParams * 5, "UChar")
    NumPut(offset, injectData, validParams * 5 + 1, "Int")
    
    if(bCleanupStack) {
        NumPut(0xC483, injectData, validParams * 5 + 5, "UShort")
        NumPut(validParams*4, injectData, validParams * 5 + 7, "UChar")
        
        NumPut(0xC3, injectData, validParams * 5 + 8, "UChar")
    } else {
        NumPut(0xC3, injectData, validParams * 5 + 5, "UChar")
    }
    
    writeRaw(hGTA, pInjectFunc, &injectData, dwLen)
    if(ErrorLevel)
        return false
    
    hThread := createRemoteThread(hGTA, 0, 0, pInjectFunc, 0, 0, 0)
    if(ErrorLevel)
        return false
    
    waitForSingleObject(hThread, 0xFFFFFFFF)
    
    closeProcess(hThread)
    
    return true
}

; internal stuff
virtualAllocEx(hProcess, dwSize, flAllocationType, flProtect) {
    if(!hProcess) {
        ErrorLevel := ERROR_INVALID_HANDLE
        return 0
    }
    
    dwRet := DllCall(    "VirtualAllocEx"
                        , "UInt", hProcess
                        , "UInt", 0
                        , "UInt", dwSize
                        , "UInt", flAllocationType
                        , "UInt", flProtect
                        , "UInt")
    if(dwRet == 0) {
        ErrorLEvel := ERROR_ALLOC_MEMORY
        return 0
    }
    
    ErrorLevel := ERROR_OK
    return dwRet
}

; internal stuff
virtualFreeEx(hProcess, lpAddress, dwSize, dwFreeType) {
    if(!hProcess) {
        ErrorLevel := ERROR_INVALID_HANDLE
        return 0
    }
    
    dwRet := DllCall(    "VirtualFreeEx"
                        , "UInt", hProcess
                        , "UInt", lpAddress
                        , "UInt", dwSize
                        , "UInt", dwFreeType
                        , "UInt")
    if(dwRet == 0) {
        ErrorLEvel := ERROR_FREE_MEMORY
        return 0
    }
    
    ErrorLevel := ERROR_OK
    return dwRet
}

; internal stuff
createRemoteThread(hProcess, lpThreadAttributes, dwStackSize, lpStartAddress, lpParameter, dwCreationFlags, lpThreadId) {
    if(!hProcess) {
        ErrorLevel := ERROR_INVALID_HANDLE
        return 0
    }
    
    dwRet := DllCall(    "CreateRemoteThread"
                        , "UInt", hProcess
                        , "UInt", lpThreadAttributes
                        , "UInt", dwStackSize
                        , "UInt", lpStartAddress
                        , "UInt", lpParameter
                        , "UInt", dwCreationFlags
                        , "UInt", lpThreadId
                        , "UInt")
    if(dwRet == 0) {
        ErrorLEvel := ERROR_ALLOC_MEMORY
        return 0
    }
    
    ErrorLevel := ERROR_OK
    return dwRet
}

; internal stuff
waitForSingleObject(hThread, dwMilliseconds) {
    if(!hThread) {
        ErrorLevel := ERROR_INVALID_HANDLE
        return 0
    }
    
    dwRet := DllCall(    "WaitForSingleObject"
                        , "UInt", hThread
                        , "UInt", dwMilliseconds
                        , "UInt")
    if(dwRet == 0xFFFFFFFF) {
        ErrorLEvel := ERROR_WAIT_FOR_OBJECT
        return 0
    }
    
    ErrorLevel := ERROR_OK
    return dwRet
}

; internal stuff
__ansiToUnicode(sString, nLen = 0) {
   If !nLen
   {
      nLen := DllCall("MultiByteToWideChar"
      , "Uint", 0
      , "Uint", 0
      , "Uint", &sString
      , "int",  -1
      , "Uint", 0
      , "int",  0)
   }

   VarSetCapacity(wString, nLen * 2)

   DllCall("MultiByteToWideChar"
      , "Uint", 0
      , "Uint", 0
      , "Uint", &sString
      , "int",  -1
      , "Uint", &wString
      , "int",  nLen)
      
    return wString
}

; internal stuff
__unicodeToAnsi(wString, nLen = 0) {
   pString := wString + 1 > 65536 ? wString : &wString

   If !nLen
   {
      nLen := DllCall("WideCharToMultiByte"
      , "Uint", 0
      , "Uint", 0
      , "Uint", pString
      , "int",  -1
      , "Uint", 0
      , "int",  0
      , "Uint", 0
      , "Uint", 0)
   }

   VarSetCapacity(sString, nLen)

   DllCall("WideCharToMultiByte"
      , "Uint", 0
      , "Uint", 0
      , "Uint", pString
      , "int",  -1
      , "str",  sString
      , "int",  nLen
      , "Uint", 0
      , "Uint", 0)
    return sString
}
Utf8ToAnsi(ByRef Utf8String, CodePage = 1251)
{
    If (NumGet(Utf8String) & 0xFFFFFF) = 0xBFBBEF
        BOM = 3
    Else
        BOM = 0
    UniSize := DllCall("MultiByteToWideChar", "UInt", 65001, "UInt", 0
    , "UInt", &Utf8String + BOM, "Int", -1
    , "Int", 0, "Int", 0)
    VarSetCapacity(UniBuf, UniSize * 2)
    DllCall("MultiByteToWideChar", "UInt", 65001, "UInt", 0
    , "UInt", &Utf8String + BOM, "Int", -1
    , "UInt", &UniBuf, "Int", UniSize)
    AnsiSize := DllCall("WideCharToMultiByte", "UInt", CodePage, "UInt", 0
    , "UInt", &UniBuf, "Int", -1
    , "Int", 0, "Int", 0
    , "Int", 0, "Int", 0)
    VarSetCapacity(AnsiString, AnsiSize)
    DllCall("WideCharToMultiByte", "UInt", CodePage, "UInt", 0
    , "UInt", &UniBuf, "Int", -1
    , "Str", AnsiString, "Int", AnsiSize
    , "Int", 0, "Int", 0)
    Return AnsiString
}



;######################################################################################################
;###################################       Quick Answer    ############################################
;######################################################################################################
#IfWinActive GTA:SA:MP


;######################################################################################################
;##################################   Команды саппортов    ############################################
;######################################################################################################
!Z::
izi:="-1"
FormatTime, CurrentDateTime,, dd.MM.yy
File = %A_MyDocuments%\GTA San Andreas User Files\SAMP\chatlog.txt
Loop, Read, %File%
{
    if RegExMatch(A_LoopReadLine, "->Вопрос\s[A-Za-z_0-9]*?\[(\d+)\]", id)
    izi:=id1
}
if (izi!="-1")
Sendinput {F6}/pm %izi%{space}
return

End::
SendInput, {f6}/sc{space}
return
!X::
SendInput, {f6}/pm{space}
return
!N::
SendInput, {f6}/supports{enter}
return
!M::
SendInput, {f6}/admins{enter}
return
;######################################################################################################
;##################################    Слив авто в гос     ############################################
;######################################################################################################
::/proc4::
::/proc5::
::/proc6::
::/proc7::
::/proc8::
::/proc9::
::/proc10::
::/proc11::
::/proc12::
::/proc13::
::/proc14::
::/proc15::
::/proc16::
::/proc17::
::/proc18::
::/proc19::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Возвращается 30 процентов от гос.суммы
return
::/proc20::
::/proc21::
::/proc22::
::/proc23::
::/proc24::
::/proc25::
::/proc26::
::/proc27::
::/proc28::
::/proc29::
::/proc30::
::/proc31::
::/proc32::
::/proc33::
::/proc34::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Возвращается 47,5 процентов от гос.суммы
return
::/proc35::
::/proc36::
::/proc37::
::/proc38::
::/proc39::
::/proc40::
::/proc41::
::/proc42::
::/proc43::
::/proc44::
::/proc45::
::/proc46::
::/proc47::
::/proc48::
::/proc49::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Возвращается 48,572 процента от гос.суммы
return
::/proc50::
::/proc51::
::/proc52::
::/proc53::
::/proc54::
::/proc55::
::/proc56::
::/proc57::
::/proc58::
::/proc59::
::/proc60::
::/proc61::
::/proc62::
::/proc63::
::/proc64::
::/proc65::
::/proc66::
::/proc67::
::/proc68::
::/proc69::
::/proc70::
::/proc71::
::/proc72::
::/proc73::
::/proc74::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Возвращается 49 процентов от гос.суммы
return
::/proc75::
::/proc76::
::/proc77::
::/proc78::
::/proc79::
::/proc80::
::/proc81::
::/proc82::
::/proc83::
::/proc84::
::/proc85::
::/proc86::
::/proc87::
::/proc88::
::/proc89::
::/proc90::
::/proc91::
::/proc92::
::/proc93::
::/proc94::
::/proc95::
::/proc96::
::/proc97::
::/proc98::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Возвращается 49,334 процента от гос.суммы
return
::/proc99::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Возвращается 49,485 процентов от гос.суммы
return
::/proc100::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Возвращается 49,5 процентов от гос.суммы
return


;######################################################################################################
;##################################      IP серверов       ############################################
;######################################################################################################

::/ip1::
::/ip01::
SendMessage, 0x50,, 0x4190419,, A
sendinput, IP 01 сервера SAMP-RP 185.169.134.19:7777
return
::/ip3::
::/ip03::
SendMessage, 0x50,, 0x4190419,, A
sendinput, IP 03 сервера SAMP-RP 185.169.134.21:7777
return
::/ip4::
::/ip04::
SendMessage, 0x50,, 0x4190419,, A
sendinput, IP 04 сервера SAMP-RP 185.169.134.22:7777
return
::/ip5::
::/ip05::
SendMessage, 0x50,, 0x4190419,, A
sendinput, IP 05 сервера SAMP-RP 178.218.215.106:7775
return
::/ip6::
::/ip06::
SendMessage, 0x50,, 0x4190419,, A
sendinput, IP 06 сервера SAMP-RP 178.218.215.106:7776
return
::/ip7::
::/ip07::
SendMessage, 0x50,, 0x4190419,, A
sendinput, IP 07 сервера SAMP-RP 178.218.215.106:7777
return
::/ip8::
::/ip08::
SendMessage, 0x50,, 0x4190419,, A
sendinput, IP 08 сервера SAMP-RP 178.218.215.106:7778
return
::/ip9::
::/ip09::
SendMessage, 0x50,, 0x4190419,, A
sendinput, IP 09 сервера SAMP-RP 185.169.134.22:7771
return
::/ip10::
SendMessage, 0x50,, 0x4190419,, A
sendinput, IP 10 сервера SAMP-RP 178.218.215.106:7710
return
::/ip11::
SendMessage, 0x50,, 0x4190419,, A
sendinput, IP 11 сервера SAMP-RP 178.218.215.106:7711
return
::/ip12::
SendMessage, 0x50,, 0x4190419,, A
sendinput, IP 12 сервера SAMP-RP 178.218.215.106:7712
return
::/ip13::
SendMessage, 0x50,, 0x4190419,, A
sendinput, IP 13 сервера SAMP-RP 178.218.215.106:7713
return
::/ip14::
SendMessage, 0x50,, 0x4190419,, A
sendinput, IP 14 сервера SAMP-RP 178.218.215.106:7714
return
::/ip15::
SendMessage, 0x50,, 0x4190419,, A
sendinput, IP 15 сервера SAMP-RP 178.218.215.106:7715
return
::/iprevo::
::/iprevolution::
SendMessage, 0x50,, 0x4190419,, A
sendinput, IP Revolution сервера SAMP-RP 185.169.134.11:7777
return
::/ipreb::
::/ipreborn::
SendMessage, 0x50,, 0x4190419,, A
sendinput, IP Reborn сервера SAMP-RP 185.169.134.34:7777
return
::/ipleg::
::/iplegacy::
SendMessage, 0x50,, 0x4190419,, A
sendinput, IP Legacy сервера SAMP-RP 185.169.134.22:7773
return
;######################################################################################################
;##################################  Ограничитель рангов   ############################################
;######################################################################################################
::/banda7::
SendMessage, 0x50,, 0x4190419,, A
sendinput,10 уровень - 7 ранг. (Количество человек на должности не ограничивается)
return
::/banda8::
SendMessage, 0x50,, 0x4190419,, A
sendinput,13 уровень - 8 ранг. (Максимальное количество человек на должности - 15)
return
::/banda9::
SendMessage, 0x50,, 0x4190419,, A
sendinput,15 уровень - 9 ранг. (Максимальное количество человек на должности - 10)
return
::/mafia7::
SendMessage, 0x50,, 0x4190419,, A
sendinput,15 уровень - 7 ранг. (Максимальное количество человек на должности - 12)
return
::/mafia8::
SendMessage, 0x50,, 0x4190419,, A
sendinput,16 уровень - 8 ранг. (Максимальное количество человек на должности - 8)
return
::/mafia9::
SendMessage, 0x50,, 0x4190419,, A
sendinput,17 уровень - 9 ранг. (Максимальное количество человек на должности - 6)
return
::/biker6::
SendMessage, 0x50,, 0x4190419,, A
sendinput,10 уровень - 6 ранг. (Максимальное количество человек на должности - 6)
return
::/biker7::
SendMessage, 0x50,, 0x4190419,, A
sendinput,12 уровень - 7 ранг. (Максимальное количество человек на должности - 5)
return
::/biker8::
SendMessage, 0x50,, 0x4190419,, A
sendinput,14 уровень - 8 ранг. (Максимальное количество человек на должности - 4)
return
::/news7::
SendMessage, 0x50,, 0x4190419,, A
sendinput,11 уровень - 7 ранг. (Максимальное количество человек на должности - 5)
return
::/news8::
SendMessage, 0x50,, 0x4190419,, A
sendinput,13 уровень - 8 ранг. (Максимальное количество человек на должности - 4)
return
::/news9::
SendMessage, 0x50,, 0x4190419,, A
sendinput,15 уровень - 9 ранг. (Максимальное количество человек на должности - 3)
return
::/ah7::
SendMessage, 0x50,, 0x4190419,, A
sendinput,11 уровень - 8 ранг. (Максимальное количество человек на должности - 5)
return
::/ah8::
SendMessage, 0x50,, 0x4190419,, A
sendinput,13 уровень - 8 ранг. (Максимальное количество человек на должности - 3)
return
::/ah9::
SendMessage, 0x50,, 0x4190419,, A
sendinput,15 уровень - 8 ранг. (Максимальное количество человек на должности - 2)
return
::/mz7::
SendMessage, 0x50,, 0x4190419,, A
sendinput,10 уровень - 8 ранг. (Максимальное количество человек на должности - 9)
return
::/mz8::
SendMessage, 0x50,, 0x4190419,, A
sendinput,12 уровень - 8 ранг. (Максимальное количество человек на должности - 9)
return
::/mz9::
SendMessage, 0x50,, 0x4190419,, A
sendinput,14 уровень - 9 ранг. (Максимальное количество человек на должности - 6)
return
::/army12::
SendMessage, 0x50,, 0x4190419,, A
sendinput,12 уровень - 12 ранг. (Максимальное количество человек на должности - 6)
return
::/army13::
SendMessage, 0x50,, 0x4190419,, A
sendinput,14 уровень - 13 ранг. (Максимальное количество человек на должности - 5)
return
::/army14::
SendMessage, 0x50,, 0x4190419,, A
sendinput,16 уровень - 14 ранг. (Максимальное количество человек на должности - 4)
return
::/pd11::
SendMessage, 0x50,, 0x4190419,, A
sendinput,13 уровень - 11 ранг. (Максимальное количество человек на должности - 5)
return
::/pd12::
SendMessage, 0x50,, 0x4190419,, A
sendinput,14 уровень - 12 ранг. (Максимальное количество человек на должности - 4)
return
::/pd13::
SendMessage, 0x50,, 0x4190419,, A
sendinput,16 уровень - 13 ранг. (Максимальное количество человек на должности - 3)
return
::/fbi6::
::/fbr6::
SendMessage, 0x50,, 0x4190419,, A
sendinput,15 уровень - 6 ранг. (Максимальное количество человек на должности - 1)
return
::/fbr7::
::/fbi7::
SendMessage, 0x50,, 0x4190419,, A
sendinput,15 уровень - 7 ранг. (Максимальное количество человек на должности - 1)
return
::/fbi8::
::/fbr8::
SendMessage, 0x50,, 0x4190419,, A
sendinput,16 уровень - 8 ранг. (Максимальное количество человек на должности - 3)
return
::/fbi9::
::/fbr9::
SendMessage, 0x50,, 0x4190419,, A
sendinput,17 уровень - 9 ранг. (Максимальное количество человек на должности - 2)
return
::/merija5::
SendMessage, 0x50,, 0x4190419,, A
sendinput,16 уровень - 5 ранг. (Максимальное количество человек на должности - 5)
return
::/merija6::
SendMessage, 0x50,, 0x4190419,, A
sendinput,16 уровень - 6 ранг. (Максимальное количество человек на должности - 5)
return

;######################################################################################################
;##################################    Квесты     ############################################
;######################################################################################################

::/qg1::
::/qgost1::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №1. Задание: Перетаскать 20 мешков на грузчиках. Награда: 500 вирт.
return
::/qg2::
::/qgost2::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №2. Задание: Съездить в АШ и сдать экзамен на красной метке Награда: Бесплатные права.
return
::/qg3::
::/qgost3::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №3. Задание: Собрать за раз 50 шт. урожая. Награда: 1000 вирт.
return
::/qg4::
::/qgost4::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №4. Задание: Купить какую либо одежду в магазине одежды. Награда: 500 вирт.
return
::/qg5::
::/qgost5::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №5. Задание: Приехать в мэрию.
return
::/qr1::
::/qrazvl1::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №1. Задание: Сделать 10 кругов на автобусе (2 lvl). Награда: 1000 вирт.
return
::/qr2::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №2. Задание: Довезти 50 людей на такси (2 lvl). Награда: 1000 вирт.
return
::/qr3::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №3. Задание: 50 ремонтов\заправок механиком (3 lvl). Награда: 2000 вирт.
return
::/qr4::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №4. Задание: 50 рейсов инкассатором (3 lvl). Награда: 1000 вирт.
return
::/qr5::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №5. Задание: 50 контрактов прорабом (5 lvl). Награда: 1000 вирт.
return
::/qr6::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №6. Задание: 50 боев тренером (5 lvl). Награда: 1000 вирт.
return
::/qr7::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №7. Задание: 50 грузов дальнобойщиком (6 lvl). Награда: 10.000 вирт.
return
::/qr8::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №8. Задание: Купить жилье. Награда: 100.000 вирт.
return
::/qr9::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №9. Задание: Купить машину. Награда: 100.000 вирт.
return
::/qmp1::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №1. Задание: Собрать 50 грибов. Награда: 1000 вирт.
return
::/qmp2::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №2. Наловить 100кг рыбы. Награда: 5000 вирт.
return
::/qmp3::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №3. Принять участия в гонках в городе Los Santos. Награда: 1000 вирт.
return
::/qmp4::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №4. Принять участия в дерби в городе San Fierro. Награда: 1000 вирт.
return
::/qmp5::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №5. Принять участие в пейнтболе в городе Las Venturas.
return
::/qbanda1::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №1. Задание: Вступить в любую банду. Награда: 500 вирт.
return
::/qbanda2::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №2. Задание: Купить наркотики в притоне 150 грамм. Награда: 3000 вирт.
return
::/qbanda3::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №3. Задание: Украсть 500 матов с базы военной. C помощью команды /materials get.
return
::/qbanda4::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №4. Задание: Сделать себе deagle 100 патрон. Награда: 1000 вирт.
return
::/qbanda5::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №5. Задание: Украсть 10 авто (Автоугонщик).
return
::/qbanda6::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №6. Задание: Ограбить 10 домов. (/robhouse - 50 матов должно быть)
return
::/qbanda7::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №7. Задание: Участвовать в 20 террах. Награда: 1000 вирт.
return
::/qbanda8::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №8. Задание: Добыть военную форму. Награда: 10.000 вирт.
return
::/qbanda9::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №9. Задание: Выгрузить на склад банды 50000 материалов. Награда: 5.000 вирт.
return
::/qbanda10::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №10. Задание: Добыть 3 ключа от камер. Награда: 10.000 вирт. (убить копа в гетто)
return
::/qbanda11::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №11. Задание: Убить агента ФБР. Награда: 100.000 вирт.
return
::/qbiker1::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №1. Задание: Вступить в байк-клуб. Награда: 500 вирт.
return
::/qbiker2::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №2. Задание: Купить 100 грамм наркотиков. Награда: 3000 вирт.
return
::/qbiker3::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №3. Задание: Отсидеться пока копы не забудут про вас. Награда: 1000 вирт.
return
::/qbiker4::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №4. Задание: Побывать на 10 войнах за бизнес. Награда: 1000 вирт.
return
::/qbiker5::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №5. Задание: Ограбить 20 военных фур. Награда: 10.000 вирт.
return
::/qbiker6::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №6. Задание: Ограбить 20 Дальнобойщиков. Награда: 10.000 вирт.
return
::/qbiker7::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №7. Задание: Задача 1: Войте в АММО SF. | Задача 2: Войти в банк.
return
::/qmaf1::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №1. Задание: Вступить в Мафию. Награда: 500 вирт.
return
::/qmaf2::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №2. Задание: Выбить долг у троих должников. Награда: 1000 вирт. (/getdebt [id])
return
::/qmaf3::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №3. Задание: Поставить 5 крыш (/setdebt [id]). Награда: 1000 вирт.
return
::/qmaf4::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №4. Задание: Снять себе розыска командой /hackbase. Награда: 1000 вирт.
return
::/qmaf5::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №5. Задание: Поучаствовать в 20 войнах за бизнес. Награда: 10.000 вирт.
return
::/qmaf6::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №6. Задание: Сыграть по крупному. Поставить ставку 10.000 вирт на рулетку. Награда: 10.000 вирт.
return
::/qmaf7::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №7. Задание: Убить адвоката. Награда: 10.000 вирт.
return
::/qmaf8::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №8. Задание: Использовать команду /tie, чтобы похитить агента ФБР. Награда: 10.000 вирт.
return
::/qmaf9::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №9. Задание: Попасть в тюрьму; выйти из неё, а потом зайти в банк.
return
::/qarm1::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №1. Задание: Вступить в армию. Награда: 500 вирт.
return
::/qarm2::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №2. Задание: Прокачать M4A1 до 100 процентов. Награда: 1000 вирт.
return
::/qarm3::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №3. Задание: Убить 25 бандитов на территории армии. Награда: 1000 вирт.
return
::/qarm4::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №4. Задание: Сделать 50 поставок. Награда: 1000 вирт (Квест Патриот).
return
::/qarm5::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №5. Задание: Сделать 30 поставок в порт Лос Сантос.
return
::/qp1::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №1. Задание: Вступить в ПД. Награда: 500 вирт.
return
::/qp2::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №2. Задание: Проверить 50 паспортов. Награда: 1000 вирт.
return
::/qp3::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №3. Задание: Выписать 20 штрафов. Награда: 1000 вирт. (/ticket)
return
::/qp4::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №4. Задание: Забрать 20 прав. Награда: 1000 вирт. (/take)
return
::/qp5::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №5. Задание: принять 20 вызовов /c. Награда: 1000 вирт.
return
::/qp6::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №6. Задание: Поймать 20 нарушителей по /patrul. Награда: 1000 вирт.
return
::/qp7::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №7. Задание: Вам нужно провести 20 арестов ( /arrest ). Награда: 1000 вирт.
return
::/qp8::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №8. Задание: Вам следует проверить 20-ти водителей на состояние алкоголя в крови ( /bh ).
return
::/qfbr1::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №1. Задание: Вступить в ФБР. Награда: 500 вирт.
return
::/qfbr2::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №2. Задание: Обыскать 20 подозрительных человек. Награда: 1000 вирт. (/frisk)
return
::/qfbr3::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №3. Задание: Изъять 20 запрещенных предметов. Награда: 1000 вирт. (/take)
return
::/qfbr4::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №4. Задание: Найти преступника у которого 5-6 зв - 20шт. Награда: 1000 вирт. (/mdc)
return
::/qfbr5::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №5. Задание: Арестовать 20 чел 5-6 зв. Награда: 1000 вирт.
return
::/qfbr6::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №6. Задание: Установить прослушку в 5 криминальных элементах. Награда: 1000 вирт.(/tipster set)
return
::/qfbr7::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №7. Задание: Закрыть бизнес без лицензии. (/bizlock)
return
::/qmed1::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №1. Задание: Вступить в МЧС. Награда: 500 вирт.
return
::/qmed2::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №2. Задание: Вылечить 20 тел. Награда: 1000 вирт. (/heal)
return
::/qmed3::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №3. Задание: Принять 20 вызовов. Награда: 1000 вирт.
return
::/qmed4::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №4. Задание: Отрезвить 20 тел. Награда: 1000 вирт.(/heal)
return
::/qmed5::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №5. Задание: Провести 20 сеансов от нарко зависимости. Награда: 1000 вирт. (/healaddict)
return
::/qah1::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №1. Задание: Вступить в АШ. Награда: 500 вирт.
return
::/qah2::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №2. Задание: 20 уроков по вождение. Награда: 1000 вирт.
return
::/qah3::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №3. Задание: Выдать 100 водительских прав. Награда: 1000 вирт.
return
::/qah4::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №4. Задание: Продать 100 лицензий на рыбалку. Награда: 1000 вирт.
return
::/qah5::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №5. Задание: Продать 100 лицензий на водный транспорт. Награда: 1000 вирт.
return
::/qah6::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №6. Задание: Продать 100 лицензий на воздушный транспорт. Награда: 1000 вирт.
return
::/qah7::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №7. Задание: Продать 50 лицензий на оружие. Награда: 1000 вирт.
return
::/qah8::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №8. Задание: Продать 5 лицензий на бизнес.
return
::/qnews1::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №1. Задание: Вступить в редакцию новостей. Награда: 500 вирт.
return
::/qnews2::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №2. Задание: Отредактировать 100 объявлений. Награда: 1000 вирт.
return
::/qnews3::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №3. Задание: 100 смсок в эфир собрать. Награда: 1000 вирт.
return
::/qnews4::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №4. Задание: Принять 100 звонков от слушателей. Награда: 1000 вирт. (/ncall)
return
::/qnews5::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №5. Задание: Взять интервью у полицейского. Награда: 1000 вирт.
return
::/qnews6::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №6. Задание: Взять интервью у бандита. Награда: 1000 вирт.
return
::/qnews7::
SendMessage, 0x50,, 0x4190419,, A
sendinput, Квест №7. Задание: Взять интервью у сотрудника мэрии. Награда: 1000 вирт.
return
;######################################################################################################
;##################################    Гос автомобилей     ############################################
;######################################################################################################
::/LANDSTALKER::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Landstalker [N] [Гос - 130.000 / В бонусы - 91.000] [1 проц. - 1.560] [87км/ч]
return
::/PERENNIAL::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Perenniel [N] [Гос - 100.000 / В бонусы - 70.000] [1 проц. - 1.200] [73км/ч]
return
::/PREVION::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Previon [N] [Гос - 100.000 / В бонусы - 70.000] [1 проц. - 1.200] [85км/ч]
return
::/STALLION::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Stallion [N] [Гос - 150.000 / В бонусы - 105.000] [1 проц. - 1.800] [93км/ч]
return
::/SOLAIR::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Solair [N] [Гос - 120.000 / В бонусы - 84.000] [1 проц. - 1.440] [87км/ч]
return
::/GLENDALE::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Glendale [N] [Гос - 110.000 / В бонусы - 77.000] [1 проц. - 1.320] [87км/ч]
return
::/SABRE::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Sabre [N] [Гос - 190.000 / В бонусы - 133.000] [1 проц. - 2.280] [96км/ч]
return
::/WALTON::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Walton [N] [Гос - 100.000 / В бонусы - 70.000] [1 проц. - 1.200] [75км/ч]
return
::/REGINA::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Regina [N] [Гос - 110.000 / В бонусы - 77.000] [1 проц. - 1.320] [77км/ч]
return
::/GREENWOOD::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Greenwood [N] [Гос - 140.000 / В бонусы - 98.000] [1 проц. - 1.680] [78км/ч]
return
::/NEBULA::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Nebula [N] [Гос - 140.000 / В бонусы - 98.000] [1 проц. - 1.680] [87км/ч]
return
::/MAJESTIC::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Majestic [N] [Гос - 150.000 / В бонусы - 105.000] [1 проц. - 1.800] [87км/ч]
return
::/BUCCANEER::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Buccaneer [N] [Гос - 170.000 / В бонусы - 119.000] [1 проц. - 2.040] [91км/ч]
return
::/FORTUNE::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Fortune [N] [Гос - 110.000 / В бонусы - 77.000] [1 проц. - 1.320] [87км/ч]
return
::/CADRONA::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Cadrona [N] [Гос - 100.000 / В бонусы - 70.000] [1 проц. - 1.200] [82км/ч]
return
::/CLOVER::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Clover [N] [Гос - 120.000 / В бонусы - 84.000] [1 проц. - 1.440] [91км/ч]
return
::/SADLER::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Sadler [N] [Гос - 100.000 / В бонусы - 70.000] [1 проц. - 1.200] [73км/ч]
return
::/INTRUDER::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Intruder [N] [Гос - 140.000 / В бонусы - 98.000] [1 проц. - 1.680] [82км/ч]
return
::/PRIMO::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Primo [N] [Гос - 110.000 / В бонусы - 77.000] [1 проц. - 1.320] [79км/ч]
return
::/TAMPA::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Tampa [N] [Гос - 120.000 / В бонусы - 84.000] [1 проц. - 1.440] [85км/ч]
return
::/SAVANNA::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Savanna [N] [Гос - 200.000 / В бонусы - 140.000] [1 проц. - 2.400] [96км/ч]
return
::/BRAVURA::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Bravura [D] [Гос - 340.000 / В бонусы - 238.000] [1 проц. - 4.080] [81км/ч]
return
::/SENTINAL::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Sentinal [D] [Гос - 400.000 / В бонусы - 280.000] [1 проц. - 4.800] [91км/ч]
return
::/VOODOO::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Voodoo [D] [Гос - 390.000 / В бонусы - 273.000] [1 проц. - 4.680] [93км/ч]
return
::/BOBCAT::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Bobcat [D] [Гос - 310.000 / В бонусы - 217.000] [1 проц. - 3.720] [77км/ч]
return
::/PREMIER::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Premier [D] [Гос - 420.000 / В бонусы - 294.000] [1 проц. - 5.040] [94км/ч]
return
::/OCEANIC::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Oceanic [D] [Гос - 390.000 / В бонусы - 273.000] [1 проц. - 4.680] [87км/ч]
return
::/HERMES::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Hermes [D] [Гос - 370.000 / В бонусы - 259.000] [1 проц. - 4.440] [82км/ч]
return
::/BLISTA::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Blista [D] [Гос - 480.000 / В бонусы - 336.000] [1 проц. - 5.760] [90км/ч]
return
::/ELEGANT::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Elegant [D] [Гос - 450.000 / В бонусы - 315.000] [1 проц. - 5.400] [92км/ч]
return
::/WILLARD::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Willard [D] [Гос - 440.000 / В бонусы - 308.000] [1 проц. - 5.280] [82км/ч]
return
::/BLADE::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Blade [D] [Гос - 400.000 / В бонусы - 280.000] [1 проц. - 4.800] [96км/ч]
return
::/VINCENT::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Vincent [D] [Гос - 330.000 / В бонусы - 231.000] [1 проц. - 3.960] [82км/ч]
return
::/SUNRISE::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Sunrice [D] [Гос - 480.000 / В бонусы - 336.000] [1 проц. - 5.760] [80км/ч]
return
::/MERIT::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Merit [D] [Гос - 480.000 / В бонусы - 336.000] [1 проц. - 5.760] [87км/ч]
return
::/TAHOMA::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Tahoma [D] [Гос - 340.000 / В бонусы - 238.000] [1 проц. - 4.080] [88км/ч]
return
::/BROADWAY::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Broadway [D] [Гос - 460.000 / В бонусы - 322.000] [1 проц. - 5.520] [87км/ч]
return
::/TORNADO::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Tornado [D] [Гос - 350.000 / В бонусы - 245.000] [1 проц. - 4.200] [87км/ч]
return
::/EMPEROR::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Emperor [D] [Гос - 360.000 / В бонусы - 252.000] [1 проц. - 4.320] [87км/ч]
return
::/PICADOR::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Picador [D] [Гос - 420.000 / В бонусы - 294.000] [1 проц. - 5.040] [82км/ч]
return
::/MOONBEAM::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Moonbeam [C] [Гос - 700.000 / В бонусы - 490.000] [1 проц. - 8.400] [64км/ч]
return
::/ESPERANTO::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Esperanto [C] [Гос - 800.000 / В бонусы - 560.000] [1 проц. - 9.600] [82км/ч]
return
::/WASHINGTON::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Washington [C] [Гос - 830.000 / В бонусы - 581.000] [1 проц. - 9.960] [82км/ч]
return
::/ADMIRAL::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Admiral [C] [Гос - 810.000 / В бонусы - 567.000] [1 проц. - 9.720] [90км/ч]
return
::/RANCHER::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Rancher [C] [Гос - 880.000 / В бонусы - 616.000] [1 проц. - 10.560] [77км/ч]
return
::/VIRGO::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Virgo [C] [Гос - 800.000 / В бонусы - 560.000] [1 проц. - 9.600] [82км/ч]
return
::/FELTZER::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Feltzer [C] [Гос - 920.000 / В бонусы - 644.000] [1 проц. - 11.040] [90км/ч]
return
::/REMINGTON::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Remington [C] [Гос - 760.000 / В бонусы - 532.000] [1 проц. - 9.120] [93км/ч]
return
::/YOSEMITE::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Yosemite [C] [Гос - 840.000 / В бонусы - 588.000] [1 проц. - 10.080] [84км/ч]
return
::/WINDSOR::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Windsor [C] [Гос - 940.000 / В бонусы - 658.000] [1 проц. - 11.280] [87км/ч]
return
::/STRATUM::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Stratum [C] [Гос - 910.000 / В бонусы - 637.000] [1 проц. - 10.920] [85км/ч]
return
::/HUNTLEY::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Huntley [C] [Гос - 940.000 / В бонусы - 658.000] [1 проц. - 11.280] [87км/ч]
return
::/STAFFORD::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Stafford [C] [Гос - 1.000.000 / В бонусы - 700.000] [1 проц. - 12.000] [85км/ч]
return
::/CLUB::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Club [C] [Гос - 770.000 / В бонусы - 539.000] [1 проц. - 9.240] [90км/ч]
return
::/PHOENIX::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Phoenix [C] [Гос - 750.000 / В бонусы - 525.000] [1 проц. - 9.000] [95км/ч]
return
::/PCJ::
SendMessage, 0x50,, 0x4190419,, A
sendinput,PCJ-600 [C] [Гос - 1.000.000 / В бонусы - 700.000] [1 проц. - 12.000] [88км/ч]
return
::/BF::
SendMessage, 0x50,, 0x4190419,, A
sendinput,BF-400 [C] [Гос - 1.000.000 / В бонусы - 700.000] [1 проц. - 12.000] [88км/ч]
return
::/WAYFARER::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Wayfarer [C] [Гос - 800.000 / В бонусы - 560.000] [1 проц. - 9.600] [87км/ч]
return
::/ZR::
SendMessage, 0x50,, 0x4190419,, A
sendinput,ZR-350 [B] [Гос - 2.200.000 / В бонусы - 1.540.000] [1 проц. - 26.400] [103км/ч]
return
::/COMET::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Comet [B] [Гос - 2.400.000 / В бонусы - 1.680.000] [1 проц. - 28.800] [102км/ч]
return
::/SLAMVAN::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Slamvan [B] [Гос - 2.000.000 / В бонусы - 1.400.000] [1 проц. - 24.000] [87км/ч]
return
::/HUSTLER::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Hustler [B] [Гос - 1.900.000 / В бонусы - 1.330.000] [1 проц. - 22.800] [81км/ч]
return
::/URANUS::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Uranus [B] [Гос - 2.100.000 / В бонусы - 1.470.000] [1 проц. - 25.200] [86км/ч]
return
::/JESTER::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Jester [B] [Гос - 2.200.000 / В бонусы - 1.540.000] [1 проц. - 26.400] [98км/ч]
return
::/SUPRA::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Supra [B] [Гос - 2.200.000 / В бонусы - 1.540.000] [1 проц. - 26.400] [98км/ч]
return
::/SULTAN::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Sultan [B] [Гос - 2.250.000 / В бонусы - 1.575.000] [1 проц. - 27.000] [94км/ч]
return
::/ELEGY::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Elegy [B] [Гос - 2.200.000 / В бонусы - 1.540.000] [1 проц. - 26.400] [98км/ч]
return
::/FLASH::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Flash [B] [Гос - 2.100.000 / В бонусы - 1.470.000] [1 проц. - 25.200] [91км/ч]
return
::/EUROS::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Euros [B] [Гос - 2.100.000 / В бонусы - 1.470.000] [1 проц. - 25.200] [91км/ч]
return
::/ALPHA::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Alpha [B] [Гос - 2.000.000 / В бонусы - 1.400.000] [1 проц. - 24.000] [93км/ч]
return
::/FCR::
SendMessage, 0x50,, 0x4190419,, A
sendinput,FCR-900 [B] [Гос - 1.900.000 / В бонусы - 1.330.000] [1 проц. - 22.800] [88км/ч]
return
::/FREEWAY::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Freeway [B] [Гос - 2.000.000 / В бонусы - 1.400.000] [1 проц. - 24.000] [79км/ч]
return
::/SANCHEZ::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Sanchez [B] [Гос - 1.900.000 / В бонусы - 1.330.000] [1 проц. - 22.800] [79км/ч]
return
::/QUAD::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Quad [B] [Гос - 2.100.000 / В бонусы - 1.470.000] [1 проц. - 25.200] [61км/ч]
return
::/BUFFALO::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Buffalo [A] [Гос - 4.800.000 / В бонусы - 3.360.000] [1 проц. - 57.600] [103км/ч]
return
::/INFERNUS::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Infernus [A] [Гос - 6.000.000 / В бонусы - 4.200.000] [1 проц. - 72.000] [122км/ч]
return
::/CHEETAH::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Cheetah [A] [Гос - 5.600.000 / В бонусы - 3.920.000] [1 проц. - 67.200] [106км/ч]
return
::/BANSHEE::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Banshee [A] [Гос - 5.400.000 / В бонусы - 3.780.000] [1 проц. - 64.800] [112км/ч]
return
::/TURISMO::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Turismo [A] [Гос - 6.000.000 / В бонусы - 4.200.000] [1 проц. - 72.000] [107км/ч]
return
::/SUPERGT::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Super GT [A] [Гос - 5.100.000 / В бонусы - 3.570.000] [1 проц. - 61.200] [99км/ч]
return
::/BULLET::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Bullet [A] [Гос - 6.000.000 / В бонусы - 4.200.000] [1 проц. - 72.600] [112км/ч]
return
::/NRG::
SendMessage, 0x50,, 0x4190419,, A
sendinput,NRG-500 [A] [Гос - 4.600.000 / В бонусы - 3.220.000] [1 проц. - 55.200] [98км/ч]
return
::/HOTKNIFE::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Hotknife [A] [Гос - 4.800.000 / В бонусы - 3.360.000] [1 проц. - 57.600] [92км/ч]
return
::/BFINJECTION::
SendMessage, 0x50,, 0x4190419,, A
sendinput,BF Injection [A] [Гос - 5.000.000 / В бонусы - 3.500.000] [1 проц. - 60.000] [75км/ч]
return
::/SANDKING::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Sandking [A] [Гос - 5.800.000 / В бонусы - 4.060.000] [1 проц. - 69.600] [97км/ч]
return
::/HOTRING::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Hotring Racer [A] [Гос - 6.000.000 / В бонусы - 4.200.000] [1 проц. - 72.000] [119км/ч]
return
;######################################################################################################
;##################################       Гос домов        ############################################
;######################################################################################################
::/ID0::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 300 000 | Квадрат: Н-2 / За АММО СФ (/gpshouse 0)
return
::/ID1::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 120 000 | Квадрат: Ф-21 / За притоном (/gpshouse 1)
return
::/ID2::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 4 100 000 | Квадрат: К-2 / Элитный район СФ (/gpshouse 2)
return
::/ID3::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 200 000 | Квадрат: C-17 / У VineWood Burger (/gpshouse 3)
return
::/ID4::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 100 000 | Квадрат: Ц-22 / На районе Ballas (/gpshouse 4).
return
::/ID5::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 150 000 | Квадрат: Ц-23 / У Ballas (/gpshouse 5).
return
::/ID6::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 4 600 000 | Квадрат: К-2 / Элитный район СФ (/gpshouse 6).
return
::/ID7::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 150 000 | Квадрат: T-20 / У пруда в гетто (/gpshouse 7).
return
::/ID8::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 1 700 000 | Квадрат: C-16 / г.VineWood (/gpshouse 8).
return
::/ID9::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 150 000 | Квадрат: Ф-21 / У района Grove (/gpshouse 9).
return
::/ID10::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 250 000 | Квадрат: Ф-16 / Лодочная ЛC (/gpshouse 10).
return
::/ID11::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 250 000 | Квадрат: Ф-15 / Лодочная ЛС (/gpshouse 11).
return
::/ID12::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 4 000 000 | Квадрат: К-2 / Элитный район СФ (/gpshouse 12).
return
::/ID13::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 5 000 000 | Квадрат: К-2 / Элитный район СФ (/gpshouse 13).
return
::/ID14::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 700 000 | Квадрат: У-16 / У Marina Cluck (/gpshouse 14).
return
::/ID15::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 100 000 | Квадрат: У-22 / В гетто у горы (/gpshouse 15).
return
::/ID16::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: Ф-22 / У Grove (/gpshouse 16).
return
::/ID17::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 200 000 | Квадрат: Х-21 / У Rifa (/gpshouse 17).
return
::/ID18::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 480 000 | Квадрат: Н-2 / Муравейник (/gpshouse 18).
return
::/ID19::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 4 600 000 | Квадрат: К-2 / Элитный район СФ (/gpshouse 19).
return
::/ID20::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 25 000 000 | Квадрат: Р-18 / г.VineWood (/gpshouse 20).
return
::/ID21::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 000 000 | Квадрат: T-17 / Лос-Сантос (/gpshouse 21).
return
::/ID22::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 950 000 | Квадрат: C-16 / г.VineWood (/gpshouse 22).
return
::/ID23::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [S] | Цена: 25 000 000 | Квадрат: P-16 / VineWood (/gpshouse 23).
return
::/ID24::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 2 000 000 | Квадрат: P-17 / VineWood (/gpshouse 24).
return
::/ID25::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [S] | Цена: 25 000 000 | Квадрат: T-14 / VineWood (/gpshouse 25).
return
::/ID26::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 2 000 000 | Квадрат: C-18 / г.VineWood (/gpshouse 26).
return
::/ID27::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 000 000 | Квадрат: C-18 / г.VineWood (/gpshouse 27).
return
::/ID28::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 2 100 000 | Квадрат: Г-3 / Тиерра Робада (/gpshouse 28).
return
::/ID29::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 2 100 000 | Квадрат: B-2 / Тиерра Робада (/gpshouse 29).
return
::/ID30::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 1 700 000 | Квадрат: B-3 / Тиерра Робада (/gpshouse 30).
return
::/ID31::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 1 500 000 | Квадрат: К-4 / Сан-Фиерро (/gpshouse 31).
return
::/ID32::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 600 000 | Квадрат: O-2 / Сан-Фиерро (/gpshouse 32).
return
::/ID33::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 850 000 | Квадрат: O-2 / Муравейник (/gpshouse 33).
return
::/ID34::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 000 000 | Квадрат: Р-19 / г.VineWood (/gpshouse 34).
return
::/ID35::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 000 000 | Квадрат: Р-19 / г.VineWood (/gpshouse 35).
return
::/ID36::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 500 000 | Квадрат: Р-19 / г.VineWood (/gpshouse 36).
return
::/ID37::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 15 000 000 | Квадрат: Р-18 / г.VineWood (/gpshouse 37).
return
::/ID38::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 2 000 000 | Квадрат: P-17 / VineWood (/gpshouse 38).
return
::/ID39::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [S] | Цена: 15 000 000 | Квадрат: P-17 / VineWood (/gpshouse 39).
return
::/ID40::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 15 000 000 | Квадрат: P-16 / VineWood (/gpshouse 40).
return
::/ID41::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 17 000 000 | Квадрат: P-16 / VineWood (/gpshouse 41).
return
::/ID42::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 20 000 000 | Квадрат: C-16 / VineWood (/gpshouse 42).
return
::/ID43::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 10 000 000 | Квадрат: C-16 / VineWood (/gpshouse 43).
return
::/ID44::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 6 000 000 | Квадрат: C-17 / г.VineWood "Тарелка" (/gpshouse 44).
return
::/ID45::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 3 000 000 | Квадрат: C-17 / г.VineWood (/gpshouse 45).
return
::/ID46::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 3 400 000 | Квадрат: C-16 / г.VineWood (/gpshouse 46).
return
::/ID47::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 300 000 | Квадрат: C-16 / г.VineWood (/gpshouse 47).
return
::/ID48::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 900 000 | Квадрат: C-16 / г.VineWood (/gpshouse 48).
return
::/ID49::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [S] | Цена: 25 000 000 | Квадрат: T-15 / г.VineWood (/gpshouse 49).
return
::/ID50::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 4 600 000 | Квадрат: T-15 / г.VineWood (/gpshouse 50).
return
::/ID51::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 4 700 000 | Квадрат: T-15 / VineWood (/gpshouse 51).
return
::/ID52::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 4 100 000 | Квадрат: T-15 / VineWood (/gpshouse 52).
return
::/ID53::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 2 000 000 | Квадрат: У-14 / VineWood (/gpshouse 53).
return
::/ID54::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [S] | Цена: 25 000 000 | Квадрат: У-14 / VineWood (/gpshouse 54).
return
::/ID55::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [S] | Цена: 20 000 000 | Квадрат: У-14 / VineWood (/gpshouse 55).
return
::/ID56::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [S] | Цена: 20 000 000 | Квадрат: У-13 / VineWood (/gpshouse 56).
return
::/ID57::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 25 000 000 | Квадрат: У-14 / VineWood (/gpshouse 57).
return
::/ID58::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [S] | Цена: 25 000 000 | Квадрат: T-14 / VineWood (/gpshouse 58).
return
::/ID59::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 1 600 000 | Квадрат: T-14 / VineWood (/gpshouse 59).
return
::/ID60::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 1 600 000 | Квадрат: T-15 / VineWood (/gpshouse 60).
return
::/ID61::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 3 000 000 | Квадрат: T-14 / VineWood (/gpshouse 61).
return
::/ID62::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 3 500 000 | Квадрат: A-19/Б-19 / У Yakuza (/gpshouse 62).
return
::/ID63::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [S] | Цена: 25 000 000 | Квадрат: Р-18 / г.VineWood (/gpshouse 63).
return
::/ID64::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 400 000 | Квадрат: Ф-22 / У Grove (/gpshouse 64).
return
::/ID65::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 130 000 | Квадрат: Ф-22 / У Grove (/gpshouse 65).
return
::/ID66::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 100 000 | Квадрат: Ф-22 / У Grove (/gpshouse 66).
return
::/ID67::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 100 000 | Квадрат: Ф-22 / У Grove (/gpshouse 67).
return
::/ID68::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 100 000 | Квадрат: Ф-23 / У Grove (/gpshouse 68).
return
::/ID69::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 140 000 | Квадрат: Ц-23 / У Ballas (/gpshouse 69).
return
::/ID70::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 140 000 | Квадрат: Ц-23 / У Ballas (/gpshouse 70).
return
::/ID71::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 100 000 | Квадрат: Ц-23 / У Ballas (/gpshouse 71).
return
::/ID72::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 120 000 | Квадрат: Ц-23 / У Ballas (/gpshouse 72).
return
::/ID73::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 150 000 | Квадрат: Ц-23 / У Ballas (/gpshouse 73).
return
::/ID74::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 100 000 | Квадрат: Ц-23 / У Ballas (/gpshouse 74).
return
::/ID75::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 150 000 | Квадрат: Ц-19 / У Aztec (/gpshouse 75).
return
::/ID76::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 370 000 | Квадрат: Ц-19 / У Aztec (/gpshouse 76).
return
::/ID77::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 100 000 | Квадрат: Ц-19 / У Aztec (/gpshouse 77).
return
::/ID78::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 200 000 | Квадрат: Ц-19 / У Aztec (/gpshouse 78).
return
::/ID79::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 100 000 | Квадрат: Ц-19 / У Aztec (/gpshouse 79).
return
::/ID80::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 180 000 | Квадрат: Ц-20 / У Aztec (/gpshouse 80).
return
::/ID81::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 100 000 | Квадрат: Ц-20 / У Aztec (/gpshouse 81).
return
::/ID82::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 400 000 | Квадрат: Ц-20 / У Aztec (/gpshouse 82).
return
::/ID83::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 150 000 | Квадрат: Ц-19 / У Aztec (/gpshouse 83).
return
::/ID84::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 130 000 | Квадрат: Ц-19 / У Aztec (/gpshouse 84).
return
::/ID85::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 100 000 | Квадрат: Ц-20 / У Aztec (/gpshouse 85).
return
::/ID86::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 150 000 | Квадрат: Ц-20 / У Aztec (/gpshouse 86).
return
::/ID87::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 100 000 | Квадрат: Ц-20 / У Aztec (/gpshouse 87).
return
::/ID88::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 170 000 | Квадрат: Х-21 / У Rifa (/gpshouse 88).
return
::/ID89::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 130 000 | Квадрат: Х-21 / У Rifa (/gpshouse 89).
return
::/ID90::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 130 000 | Квадрат: Х-21 / У Rifa (/gpshouse 90).
return
::/ID91::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 300 000 | Квадрат: Ф-21 / У бара Alhambra (/gpshouse 91).
return
::/ID92::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 300 000 | Квадрат: Ф-21 / У бара Alhambra (/gpshouse 92).
return
::/ID93::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 300 000 | Квадрат: Ф-21 / У бара Alhambra (/gpshouse 93).
return
::/ID94::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 100 000 | Квадрат: Ф-21 / У бара Alhambra (/gpshouse 94).
return
::/ID95::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 150 000 | Квадрат: Ф-21 / У бара Alhambra (/gpshouse 95).
return
::/ID96::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 200 000 | Квадрат: Ф-21 / У бара Alhambra (/gpshouse 96).
return
::/ID97::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 140 000 | Квадрат: Ф-21 / У бара Alhambra (/gpshouse 97).
return
::/ID98::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 150 000 | Квадрат: Ф-21 / У бара Alhambra (/gpshouse 98).
return
::/ID99::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 320 000 | Квадрат: Ф-21 / У заправки в гетто (/gpshouse 99).
return
::/ID100::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 120 000 | Квадрат: Ф-21 / У заправки в гетто (/gpshouse 100).
return
::/ID101::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 300 000 | Квадрат: Ф-21 / У заправки в гетто (/gpshouse 101).
return
::/ID102::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 630 000 | Квадрат: Ф-20 / У заправки в гетто (/gpshouse 102).
return
::/ID103::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 300 000 | Квадрат: Ф-20 / У заправки в гетто (/gpshouse 103).
return
::/ID104::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 440 000 | Квадрат: Ф-20 / У заправки в гетто (/gpshouse 104).
return
::/ID105::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 320 000 | Квадрат: Ф-22 / У Grove (/gpshouse 105).
return
::/ID106::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 330 000 | Квадрат: Ф-22 / У Grove (/gpshouse 106).
return
::/ID107::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 200 000 | Квадрат: Ф-22 / У Grove (/gpshouse 107).
return
::/ID108::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 250 000 | Квадрат: Ф-22 / У Grove (/gpshouse 108).
return
::/ID109::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 120 000 | Квадрат: Ф-22 / У Grove (/gpshouse 109).
return
::/ID110::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 120 000 | Квадрат: Ф-22 / У Grove (/gpshouse 110).
return
::/ID111::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 200 000 | Квадрат: Ф-22 / У Grove (/gpshouse 111).
return
::/ID112::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 150 000 | Квадрат: Ф-22 / У Grove (/gpshouse 112).
return
::/ID113::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 340 000 | Квадрат: Ф-22 / У района Grove (/gpshouse 113).
return
::/ID114::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 250 000 | Квадрат: Ф-22 / У района Grove (/gpshouse 114).
return
::/ID115::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 130 000 | Квадрат: Ф-22 / У района Grove (/gpshouse 115).
return
::/ID116::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 240 000 | Квадрат: Ф-22 / У района Grove (/gpshouse 116).
return
::/ID117::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 300 000 | Квадрат: Ф-22 / У района Grove (/gpshouse 117).
return
::/ID118::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 170 000 | Квадрат: У-22 / У бара Pig Pen (/gpshouse 118).
return
::/ID119::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 160 000 | Квадрат: У-22 / У бара Pig Pen (/gpshouse 119).
return
::/ID120::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 100 000 | Квадрат: У-22 / У бара Pig Pen (/gpshouse 120).
return
::/ID121::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 100 000 | Квадрат: У-22 / У бара Pig Pen (/gpshouse 121).
return
::/ID122::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 100 000 | Квадрат: У-22 / У бара Pig Pen (/gpshouse 122).
return
::/ID123::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 100 000 | Квадрат: У-22 / У бара Pig Pen (/gpshouse 123).
return
::/ID124::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 200 000 | Квадрат: У-22 / У бара Pig Pen (/gpshouse 124).
return
::/ID125::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 200 000 | Квадрат: У-22 / У бара Pig Pen (/gpshouse 125).
return
::/ID126::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 170 000 | Квадрат: У-22 / У бара Pig Pen (/gpshouse 126).
return
::/ID127::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 200 000 | Квадрат: У-22 / У бара Pig Pen (/gpshouse 127).
return
::/ID128::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 200 000 | Квадрат: У-22 / У бара Pig Pen (/gpshouse 128).
return
::/ID129::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 360 000 | Квадрат: T-22 / В гетто у горы (/gpshouse 129).
return
::/ID130::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 130 000 | Квадрат: T-22 / В гетто у горы (/gpshouse 130).
return
::/ID131::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 230 000 | Квадрат: T-22 / В гетто у горы (/gpshouse 131).
return
::/ID132::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 140 000 | Квадрат: T-22 / В гетто у горы (/gpshouse 132).
return
::/ID133::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 300 000 | Квадрат: T-22 / В гетто у горы (/gpshouse 133).
return
::/ID134::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 420 000 | Квадрат: Х-20 / У ж/д спавна в гетто (/gpshouse 134).
return
::/ID135::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 420 000 | Квадрат: Х-20 / У ж/д спавна в гетто (/gpshouse 135).
return
::/ID136::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 420 000 | Квадрат: Х-20 / У ж/д спавна в гетто (/gpshouse 136).
return
::/ID137::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 480 000 | Квадрат: Х-20 / У ж/д спавна в гетто (/gpshouse 137).
return
::/ID138::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 430 000 | Квадрат: Ф-16 / Лодочная Лос-Сантос (/gpshouse 138).
return
::/ID139::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 400 000 | Квадрат: Ф-16 / Лодочная Лос-Сантос (/gpshouse 139).
return
::/ID140::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 500 000 | Квадрат: Х-16 / Лодочная Лос-Сантос (/gpshouse 140).
return
::/ID141::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 600 000 | Квадрат: Х-16 / Лодочная Лос-Сантос (/gpshouse 141).
return
::/ID142::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 600 000 | Квадрат: Ф-16 / Лодочная Лос-Сантос (/gpshouse 142).
return
::/ID143::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 300 000 | Квадрат: Ф-16 / Лодочная Лос-Сантос (/gpshouse 143).
return
::/ID144::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 300 000 | Квадрат: Ф-16 / Лодочная Лос-Сантос (/gpshouse 144).
return
::/ID145::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 400 000 | Квадрат: Ф-16 / Лодочная Лос-Сантос (/gpshouse 145).
return
::/ID146::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 300 000 | Квадрат: Ф-15 / Лодочная Лос-Сантос (/gpshouse 146).
return
::/ID147::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 270 000 | Квадрат: Ф-15 / Лодочная Лос-Сантос (/gpshouse 147).
return
::/ID148::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 340 000 | Квадрат: Ф-15 / Лодочная Лос-Сантос (/gpshouse 148).
return
::/ID149::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 300 000 | Квадрат: Ф-15 / Лодочная Лос-Сантос (/gpshouse 149).
return
::/ID150::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 280 000 | Квадрат: Ф-15 / Лодочная Лос-Сантос (/gpshouse 150).
return
::/ID151::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 500 000 | Квадрат: Ф-15 / Лодочная Лос-Сантос (/gpshouse 151).
return
::/ID152::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 700 000 | Квадрат: У-21 / У больницы в гетто (/gpshouse 152).
return
::/ID153::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 160 000 | Квадрат: У-21 / У больницы в гетто (/gpshouse 153).
return
::/ID154::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 170 000 | Квадрат: У-21 / У больницы в гетто (/gpshouse 154).
return
::/ID155::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 120 000 | Квадрат: У-21 / У больницы в гетто (/gpshouse 155).
return
::/ID156::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 320 000 | Квадрат: У-21 / У больницы в гетто (/gpshouse 156).
return
::/ID157::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 300 000 | Квадрат: У-21 / У больницы в гетто (/gpshouse 157).
return
::/ID158::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 350 000 | Квадрат: У-21 / У больницы в гетто (/gpshouse 158).
return
::/ID159::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 200 000 | Квадрат: У-21 / У больницы в гетто (/gpshouse 159).
return
::/ID160::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 200 000 | Квадрат: У-21 / У больницы в гетто (/gpshouse 160).
return
::/ID161::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 260 000 | Квадрат: У-21 / У больницы в гетто (/gpshouse 161).
return
::/ID162::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 150 000 | Квадрат: У-21 / У больницы в гетто (/gpshouse 162).
return
::/ID163::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 130 000 | Квадрат: У-22 / У больницы в гетто (/gpshouse 163).
return
::/ID164::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 120 000 | Квадрат: У-22 / У больницы в гетто (/gpshouse 164).
return
::/ID165::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 140 000 | Квадрат: У-22 / У больницы в гетто (/gpshouse 165).
return
::/ID166::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 120 000 | Квадрат: У-22 / У больницы в гетто (/gpshouse 166).
return
::/ID167::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 130 000 | Квадрат: У-21 / У больницы в гетто (/gpshouse 167).
return
::/ID168::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 120 000 | Квадрат: У-21 / У больницы в гетто (/gpshouse 168).
return
::/ID169::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 400 000 | Квадрат: У-21 / У больницы в гетто (/gpshouse 169).
return
::/ID170::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 160 000 | Квадрат: У-21 / У больницы в гетто (/gpshouse 170).
return
::/ID171::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 130 000 | Квадрат: У-21 / У больницы в гетто (/gpshouse 171).
return
::/ID172::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 420 000 | Квадрат: У-21 / У больницы в гетто (/gpshouse 172).
return
::/ID173::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 130 000 | Квадрат: У-21 / У больницы в гетто (/gpshouse 173).
return
::/ID174::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 450 000 | Квадрат: У-21 / У отеля Jefferson (/gpshouse 174).
return
::/ID175::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 160 000 | Квадрат: У-21 / У отеля Jefferson (/gpshouse 175).
return
::/ID176::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 120 000 | Квадрат: У-21 / У отеля Jefferson (/gpshouse 176).
return
::/ID177::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 450 000 | Квадрат: У-22 / У отеля Jefferson (/gpshouse 177).
return
::/ID178::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 440 000 | Квадрат: T-22 / У отеля Jefferson (/gpshouse 178).
return
::/ID179::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 390 000 | Квадрат: T-21 / У отеля Jefferson (/gpshouse 179).
return
::/ID180::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 120 000 | Квадрат: T-21 / У отеля Jefferson (/gpshouse 180).
return
::/ID181::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 140 000 | Квадрат: T-21 / У отеля Jefferson (/gpshouse 181).
return
::/ID182::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 160 000 | Квадрат: У-21 / У отеля Jefferson (/gpshouse 182).
return
::/ID183::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 310 000 | Квадрат: У-21 / У отеля Jefferson (/gpshouse 183).
return
::/ID184::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 270 000 | Квадрат: У-21 / У отеля Jefferson (/gpshouse 184).
return
::/ID185::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 420 000 | Квадрат: У-21 / У отеля Jefferson (/gpshouse 185).
return
::/ID186::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 400 000 | Квадрат: У-21 / У больницы в гетто (/gpshouse 186).
return
::/ID187::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 000 000 | Квадрат: У-21 / У больницы в гетто (/gpshouse 187).
return
::/ID188::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 170 000 | Квадрат: У-21 / У больницы в гетто (/gpshouse 188).
return
::/ID189::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 380 000 | Квадрат: T-21 / У отеля Jefferson (/gpshouse 189).
return
::/ID190::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 200 000 | Квадрат: T-21 / У отеля Jefferson (/gpshouse 190).
return
::/ID191::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 400 000 | Квадрат: T-21 / У отеля Jefferson (/gpshouse 191).
return
::/ID192::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 160 000 | Квадрат: T-21 / У отеля Jefferson (/gpshouse 192).
return
::/ID193::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 120 000 | Квадрат: T-21 / У пруда в гетто (/gpshouse 193).
return
::/ID194::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 260 000 | Квадрат: T-21 / У пруда в гетто (/gpshouse 194).
return
::/ID195::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 310 000 | Квадрат: T-21 / У пруда в гетто (/gpshouse 195).
return
::/ID196::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 180 000 | Квадрат: T-21 / У пруда в гетто (/gpshouse 196).
return
::/ID197::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 200 000 | Квадрат: T-21 / У пруда в гетто (/gpshouse 197).
return
::/ID198::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 3100 000 | Квадрат: T-21 / У пруда в гетто (/gpshouse 198).
return
::/ID199::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 400 000 | Квадрат: T-21 / У пруда в гетто (/gpshouse 199).
return
::/ID200::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 170 000 | Квадрат: T-20 / У пруда в гетто (/gpshouse 200).
return
::/ID201::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 140 000 | Квадрат: T-20 / У пруда в гетто (/gpshouse 201).
return
::/ID202::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 120 000 | Квадрат: T-20 / У пруда в гетто (/gpshouse 202).
return
::/ID203::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 100 000 | Квадрат: T-20 / У пруда в гетто (/gpshouse 203).
return
::/ID204::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 140 000 | Квадрат: T-20 / У пруда в гетто (/gpshouse 204).
return
::/ID205::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 150 000 | Квадрат: T-20 / У пруда в гетто (/gpshouse 205).
return
::/ID206::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 110 000 | Квадрат: T-20 / У пруда в гетто (/gpshouse 206).
return
::/ID207::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 110 000 | Квадрат: T-20 / У пруда в гетто (/gpshouse 207).
return
::/ID208::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 130 000 | Квадрат: T-20 / У пруда в гетто (/gpshouse 208).
return
::/ID209::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 110 000 | Квадрат: T-20 / У пруда в гетто (/gpshouse 209).
return
::/ID210::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 150 000 | Квадрат: T-20 / У пруда в гетто (/gpshouse 210).
return
::/ID211::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 150 000 | Квадрат: T-20 / У пруда в гетто (/gpshouse 211).
return
::/ID212::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 180 000 | Квадрат: T-21 / У пруда в гетто (/gpshouse 212).
return
::/ID213::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 180 000 | Квадрат: T-21 / У пруда в гетто (/gpshouse 213).
return
::/ID214::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 150 000 | Квадрат: T-21 / У пруда в гетто (/gpshouse 214).
return
::/ID215::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 260 000 | Квадрат: T-21 / У пруда в гетто (/gpshouse 215).
return
::/ID216::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 140 000 | Квадрат: T-21 / У пруда в гетто (/gpshouse 216).
return
::/ID217::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 140 000 | Квадрат: T-21 / У пруда в гетто (/gpshouse 217).
return
::/ID218::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 120 000 | Квадрат: Ц-23 / У Ballas (/gpshouse 218).
return
::/ID219::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 120 000 | Квадрат: Ц-23 / У Ballas (/gpshouse 219).
return
::/ID220::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 150 000 | Квадрат: Ц-23 / У Ballas (/gpshouse 220).
return
::/ID221::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 270 000 | Квадрат: Ц-22 / У Ballas (/gpshouse 221).
return
::/ID222::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 120 000 | Квадрат: Ц-22 / У Ballas (/gpshouse 222).
return
::/ID223::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 160 000 | Квадрат: Ц-23 / У Ballas (/gpshouse 223).
return
::/ID224::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 160 000 | Квадрат: Ц-22 / У Ballas (/gpshouse 224).
return
::/ID225::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 180 000 | Квадрат: Ц-22 / У Ballas (/gpshouse 225).
return
::/ID226::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 700 000 | Квадрат: T-16 / У АЗС Mulholland (/gpshouse 226).
return
::/ID227::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 700 000 | Квадрат: T-16 / У АЗС Mulholland (/gpshouse 227).
return
::/ID228::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 800 000 | Квадрат: T-17 / Лос-Сантос (/gpshouse 228).
return
::/ID229::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 650 000 | Квадрат: T-18 / Лос-Сантос (/gpshouse 229).
return
::/ID230::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 800 000 | Квадрат: T-18 / Лос-Сантос (/gpshouse 230).
return
::/ID231::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 1 800 000 | Квадрат: T-18 / Лос-Сантос (/gpshouse 231).
return
::/ID232::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 800 000 | Квадрат: T-18 / Лос-Сантос (/gpshouse 232).
return
::/ID233::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 900 000 | Квадрат: T-17 / Лос-Сантос (/gpshouse 233).
return
::/ID234::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 750 000 | Квадрат: T-17 / Лос-Сантос (/gpshouse 234).
return
::/ID235::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 1 900 000 | Квадрат: T-17 / Лос-Сантос (/gpshouse 235).
return
::/ID236::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 950 000 | Квадрат: T-17 / Лос-Сантос (/gpshouse 236).
return
::/ID237::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 650 000 | Квадрат: T-17 / Лос-Сантос (/gpshouse 237).
return
::/ID238::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 900 000 | Квадрат: T-17 / Лос-Сантос (/gpshouse 238).
return
::/ID239::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 600 000 | Квадрат: T-17 / Лос-Сантос (/gpshouse 239).
return
::/ID240::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 900 000 | Квадрат: T-17 / Лос-Сантос (/gpshouse 240).
return
::/ID241::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 700 000 | Квадрат: T-17 / У VineWood Burger (/gpshouse 241).
return
::/ID242::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 800 000 | Квадрат: T-17 / У VineWood Burger (/gpshouse 242).
return
::/ID243::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 1 600 000 | Квадрат: C-18 / У слова VineWood (/gpshouse 243).
return
::/ID244::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 1 600 000 | Квадрат: C-18 / У слова VineWood (/gpshouse 244).
return
::/ID245::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 400 000 | Квадрат: Х-20 / У ж/д спавна в гетто (/gpshouse 245).
return
::/ID246::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 400 000 | Квадрат: Х-20 / У ж/д спавна в гетто (/gpshouse 246).
return
::/ID247::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 200 000 | Квадрат: Ц-20 / У Aztec (/gpshouse 247).
return
::/ID248::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 200 000 | Квадрат: Ц-20 / У Aztec (/gpshouse 248).
return
::/ID249::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 250 000 | Квадрат: Ц-20 / У Aztec (/gpshouse 249).
return
::/ID250::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 120 000 | Квадрат: Ц-20 / У Aztec (/gpshouse 250).
return
::/ID251::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 120 000 | Квадрат: Ц-20 / У Aztec (/gpshouse 251).
return
::/ID252::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 120 000 | Квадрат: Ц-20 / У Aztec (/gpshouse 252).
return
::/ID253::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 1 800 000 | Квадрат: У-24 / В гетто у горы (/gpshouse 253).
return
::/ID254::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 800 000 | Квадрат: У-24 / В гетто у горы (/gpshouse 254).
return
::/ID255::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 850 000 | Квадрат: У-24 / В гетто у горы (/gpshouse 255).
return
::/ID256::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 550 000 | Квадрат: T-24 / В гетто у горы (/gpshouse 256).
return
::/ID257::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 600 000 | Квадрат: T-24 / В гетто у горы (/gpshouse 257).
return
::/ID258::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 130 000 | Квадрат: T-23 / В гетто у горы (/gpshouse 258).
return
::/ID259::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 130 000 | Квадрат: T-23 / В гетто у горы (/gpshouse 259).
return
::/ID260::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 100 000 | Квадрат: T-23 / В гетто у горы (/gpshouse 260).
return
::/ID261::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 100 000 | Квадрат: T-23 / В гетто у горы (/gpshouse 261).
return
::/ID262::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 230 000 | Квадрат: T-23 / В гетто у горы (/gpshouse 262).
return
::/ID263::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 150 000 | Квадрат: T-23 / В гетто у горы (/gpshouse 263).
return
::/ID264::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 150 000 | Квадрат: T-23 / В гетто у горы (/gpshouse 264).
return
::/ID265::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 100 000 | Квадрат: T-22 / В гетто у горы (/gpshouse 265).
return
::/ID266::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 260 000 | Квадрат: T-22 / В гетто у горы (/gpshouse 266).
return
::/ID267::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 120 000 | Квадрат: T-22 / В гетто у горы (/gpshouse 267).
return
::/ID268::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 100 000 | Квадрат: T-22 / В гетто у горы (/gpshouse 268).
return
::/ID269::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 270 000 | Квадрат: C-22 / На горе в гетто (/gpshouse 269).
return
::/ID270::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 120 000 | Квадрат: T-23 / На горе в гетто (/gpshouse 270).
return
::/ID271::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 120 000 | Квадрат: T-23 / На горе в гетто (/gpshouse 271).
return
::/ID272::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 120 000 | Квадрат: T-23 / На горе в гетто (/gpshouse 272).
return
::/ID273::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 300 000 | Квадрат: T-23 / На горе в гетто (/gpshouse 273).
return
::/ID274::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 120 000 | Квадрат: T-22 / На горе в гетто (/gpshouse 274).
return
::/ID275::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 130 000 | Квадрат: T-22 / На горе в гетто (/gpshouse 275).
return
::/ID276::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 100 000 | Квадрат: T-22 / Гетто (/gpshouse 276).
return
::/ID277::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 130 000 | Квадрат: T-22 / Гетто (/gpshouse 277).
return
::/ID278::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 150 000 | Квадрат: T-22 / Гетто (/gpshouse 278).
return
::/ID279::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 150 000 | Квадрат: T-22 / Гетто (/gpshouse 279).
return
::/ID280::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 100 000 | Квадрат: T-23 / Гетто (/gpshouse 280).
return
::/ID281::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 120 000 | Квадрат: T-23 / Гетто (/gpshouse 281).
return
::/ID282::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 130 000 | Квадрат: T-23 / Гетто (/gpshouse 282).
return
::/ID283::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 280 000 | Квадрат: C-23 / На горе в гетто (/gpshouse 283).
return
::/ID284::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 130 000 | Квадрат: C-23 / На горе в гетто (/gpshouse 284).
return
::/ID285::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 150 000 | Квадрат: C-23 / На горе в гетто (/gpshouse 285).
return
::/ID286::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 300 000 | Квадрат: C-23 / На горе в гетто (/gpshouse 286).
return
::/ID287::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 100 000 | Квадрат: C-23 / На горе в гетто (/gpshouse 287).
return
::/ID288::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 120 000 | Квадрат: C-22 / На горе в гетто (/gpshouse 288).
return
::/ID289::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 100 000 | Квадрат: C-22 / На горе в гетто (/gpshouse 289).
return
::/ID290::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 120 000 | Квадрат: C-22 / На горе в гетто (/gpshouse 290).
return
::/ID291::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 270 000 | Квадрат: C-22 / На горе в гетто (/gpshouse 291).
return
::/ID292::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 100 000 | Квадрат: C-22 / На горе в гетто (/gpshouse 292).
return
::/ID293::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 140 000 | Квадрат: T-22 / Гетто (/gpshouse 293).
return
::/ID294::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 120 000 | Квадрат: T-22 / Гетто (/gpshouse 294).
return
::/ID295::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 100 000 | Квадрат: T-22 / Гетто (/gpshouse 295).
return
::/ID296::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 100 000 | Квадрат: T-22 / Гетто (/gpshouse 296).
return
::/ID297::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 100 000 | Квадрат: T-22 / Гетто (/gpshouse 297).
return
::/ID298::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 150 000 | Квадрат: T-22 / Гетто (/gpshouse 298).
return
::/ID299::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 270 000 | Квадрат: T-22 / Гетто (/gpshouse 299).
return
::/ID300::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 360 000 | Квадрат: Ф-21 / У бара Alhambra (/gpshouse 300).
return
::/ID301::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 380 000 | Квадрат: Ф-21 / У бара Alhambra (/gpshouse 301).
return
::/ID302::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 370 000 | Квадрат: Ф-20 / У бара Alhambra (/gpshouse 302).
return
::/ID303::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 340 000 | Квадрат: Ф-20 / У бара Alhambra (/gpshouse 303).
return
::/ID304::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 700 000 | Квадрат: T-16 / У АЗС Mulholland (/gpshouse 304).
return
::/ID305::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 700 000 | Квадрат: T-16 / У АЗС Mulholland (/gpshouse 305).
return
::/ID306::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 900 000 | Квадрат: Х-16 / Пляж Санта-Мария (/gpshouse 306).
return
::/ID307::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 900 000 | Квадрат: Х-16 / Пляж Санта-Мария (/gpshouse 307).
return
::/ID308::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 900 000 | Квадрат: Х-16 / Пляж Санта-Мария (/gpshouse 308).
return
::/ID309::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 900 000 | Квадрат: Х-16 / Пляж Санта-Мария (/gpshouse 309).
return
::/ID310::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 900 000 | Квадрат: Х-16 / Пляж Санта-Мария (/gpshouse 310).
return
::/ID311::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 900 000 | Квадрат: Х-16 / Пляж Санта-Мария (/gpshouse 311).
return
::/ID312::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 700 000 | Квадрат: У-16 / У Marina Cluck (/gpshouse 312).
return
::/ID313::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 2 000 000 | Квадрат: К-4 / Змейка СФ (/gpshouse 313).
return
::/ID314::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 5 000 000 | Квадрат: К-2 / Элитный район СФ (/gpshouse 314).
return
::/ID315::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 4 500 000 | Квадрат: К-2 / Элитный район СФ (/gpshouse 315).
return
::/ID316::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 5 000 000 | Квадрат: B-2 / Тиерра Робада (/gpshouse 316).
return
::/ID317::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 5 000 000 | Квадрат: B-2 / Тиерра Робада (/gpshouse 317).
return
::/ID318::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 4 500 000 | Квадрат: B-2 / Тиерра Робада (/gpshouse 318).
return
::/ID319::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 4 500 000 | Квадрат: B-2 / Тиерра Робада (/gpshouse 319).
return
::/ID320::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 5 000 000 | Квадрат: B-2 / Тиерра Робада (/gpshouse 320).
return
::/ID321::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 4 600 000 | Квадрат: B-2 / Тиерра Робада (/gpshouse 321).
return
::/ID322::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 4 900 000 | Квадрат: B-2 / Тиерра Робада (/gpshouse 322).
return
::/ID323::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 4 900 000 | Квадрат: B-2 / Тиерра Робада (/gpshouse 323).
return
::/ID324::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 3 000 000 | Квадрат: B-2 / Тиерра Робада (/gpshouse 324).
return
::/ID325::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 2 400 000 | Квадрат: B-2 / Тиерра Робада (/gpshouse 325).
return
::/ID326::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 5 000 000 | Квадрат: B-2 / Тиерра Робада (/gpshouse 326).
return
::/ID327::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 5 000 000 | Квадрат: B-2 / Тиерра Робада (/gpshouse 327).
return
::/ID328::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 2 600 000 | Квадрат: B-3 / Тиерра Робада (/gpshouse 328).
return
::/ID329::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 2 600 000 | Квадрат: B-3 / Тиерра Робада (/gpshouse 329).
return
::/ID330::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 2 700 000 | Квадрат: B-3 / Тиерра Робада (/gpshouse 330).
return
::/ID331::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 2 600 000 | Квадрат: B-3 / Тиерра Робада (/gpshouse 331).
return
::/ID332::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 3 000 000 | Квадрат: B-3 / Тиерра Робада (/gpshouse 332).
return
::/ID333::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 3 000 000 | Квадрат: B-3 / Тиерра Робада (/gpshouse 333).
return
::/ID334::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 2 600 000 | Квадрат: B-3 / Тиерра Робада (/gpshouse 334).
return
::/ID335::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 2 200 000 | Квадрат: O-2 / Муравейник (/gpshouse 335).
return
::/ID336::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 2 200 000 | Квадрат: O-2 / Муравейник (/gpshouse 336).
return
::/ID337::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 430 000 | Квадрат: O-2 / Муравейник (/gpshouse 337).
return
::/ID338::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 600 000 | Квадрат: O-2 / Муравейник (/gpshouse 338).
return
::/ID339::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 500 000 | Квадрат: O-2 / Муравейник (/gpshouse 339).
return
::/ID340::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 600 000 | Квадрат: O-2 / Муравейник (/gpshouse 340).
return
::/ID341::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 360 000 | Квадрат: O-2 / Муравейник (/gpshouse 341).
return
::/ID342::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 360 000 | Квадрат: O-2 / Муравейник (/gpshouse 342).
return
::/ID343::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 2 000 000 | Квадрат: O-2 / Муравейник (/gpshouse 343).
return
::/ID344::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 600 000 | Квадрат: O-2 / Муравейник (/gpshouse 344).
return
::/ID345::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 800 000 | Квадрат: O-2 / Муравейник (/gpshouse 345).
return
::/ID346::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 400 000 | Квадрат: O-2 / Муравейник (/gpshouse 346).
return
::/ID347::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 180 000 | Квадрат: Х-21 / У Rifa (/gpshouse 347).
return
::/ID348::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 360 000 | Квадрат: O-2 / Муравейник (/gpshouse 348).
return
::/ID349::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 300 000 | Квадрат: O-2 / Муравейник (/gpshouse 349).
return
::/ID350::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 450 000 | Квадрат: O-2 / Муравейник (/gpshouse 350).
return
::/ID351::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 500 000 | Квадрат: O-2 / Муравейник (/gpshouse 351).
return
::/ID352::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 300 000 | Квадрат: O-2 / Муравейник (/gpshouse 352).
return
::/ID353::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 700 000 | Квадрат: O-2 / Муравейник (/gpshouse 353)
return
::/ID354::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 600 000 | Квадрат: O-2 / Муравейник (/gpshouse 354).
return
::/ID355::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: O-2 / Муравейник (/gpshouse 355).
return
::/ID356::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 2 000 000 | Квадрат: O-2 / Муравейник (/gpshouse 356).
return
::/ID357::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 700 000 | Квадрат: И-1 / У Jizzy (/gpshouse 357).
return
::/ID358::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 2 000 000 | Квадрат: O-2 / Муравейник (/gpshouse 358).
return
::/ID359::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 380 000 | Квадрат: O-2 / Муравейник (/gpshouse 359).
return
::/ID360::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 360 000 | Квадрат: O-2 / Муравейник (/gpshouse 360).
return
::/ID361::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 2 800 000 | Квадрат: К-4 / Змейка в Сан-Фиерро (/gpshouse 361).
return
::/ID362::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 2 400 000 | Квадрат: К-4 / Змейка в Сан-Фиерро (/gpshouse 362).
return
::/ID363::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 4 000 000 | Квадрат: К-4 / Змейка в Сан-Фиерро (/gpshouse 363).
return
::/ID364::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 8 000 000 | Квадрат: К-10 / У Форт-Карсона (/gpshouse 364).
return
::/ID365::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 400 000 | Квадрат: И-13 / Форт-Карсон (/gpshouse 365).
return
::/ID366::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 400 000 | Квадрат: И-13 / Форт-Карсон (/gpshouse 366).
return
::/ID367::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 400 000 | Квадрат: И-12 / Форт-Карсон (/gpshouse 367).
return
::/ID368::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 000 000 | Квадрат: И-12 / Форт-Карсон (/gpshouse 368).
return
::/ID369::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 400 000 | Квадрат: И-12 / Форт-Карсон (/gpshouse 369).
return
::/ID370::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: И-12 / Форт-Карсон (/gpshouse 370).
return
::/ID371::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 5 000 000 | Квадрат: У-15 / Лодочная Лос-Сантос (/gpshouse 371).
return
::/ID372::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 6 000 000 | Квадрат: Б-18 / У Yakuza (/gpshouse 372).
return
::/ID373::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 4 000 000 | Квадрат: Б-18 / У Yakuza (/gpshouse 373).
return
::/ID374::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 4 000 000 | Квадрат: Б-18 / У Yakuza (/gpshouse 374).
return
::/ID375::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 2 500 000 | Квадрат: Б-19 / У Yakuza (/gpshouse 375).
return
::/ID376::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 7 500 000 | Квадрат: A-19 / У Yakuza (/gpshouse 376).
return
::/ID377::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 5 000 000 | Квадрат: П-11 / У склада продуктов (/gpshouse 377).
return
::/ID378::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 6 000 000 | Квадрат: B-9 / У дамбы (/gpshouse 378).
return
::/ID379::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 3 500 000 | Квадрат: A-19 / У Yakuza (/gpshouse 379).
return
::/ID380::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 3 500 000 | Квадрат: A-19 / У Yakuza (/gpshouse 380).
return
::/ID381::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 5 000 000 | Квадрат: A-19 / У Yakuza (/gpshouse 381).
return
::/ID382::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 2 000 000 | Квадрат: Х-14 / Пляж Санта-Мария (/gpshouse 382).
return
::/ID383::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 3 000 000 | Квадрат: O-22 / Посёлок "Sobrino" (/gpshouse 383).
return
::/ID384::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Л-20 / У перекрёстка ЛС-ЛВ (/gpshouse 384).
return
::/ID385::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Л-20 / У перекрёстка ЛС-ЛВ (/gpshouse 385).
return
::/ID386::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Л-20 / У перекрёстка ЛС-ЛВ (/gpshouse 386).
return
::/ID387::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Л-20 / У перекрёстка ЛС-ЛВ (/gpshouse 387).
return
::/ID388::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Л-21 / У "Four Dragons" (/gpshouse 388).
return
::/ID389::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Л-21 / У "Four Dragons" (/gpshouse 389).
return
::/ID390::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Л-21 / У "Four Dragons" (/gpshouse 390).
return
::/ID391::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Л-21 / У "Four Dragons" (/gpshouse 391).
return
::/ID392::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Л-21 / У "Four Dragons" (/gpshouse 392).
return
::/ID393::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Л-21 / У "Four Dragons" (/gpshouse 393).
return
::/ID394::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Л-21 / У "Four Dragons" (/gpshouse 394).
return
::/ID395::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Л-21 / У "Four Dragons" (/gpshouse 395).
return
::/ID396::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Л-21 / У "Four Dragons" (/gpshouse 396).
return
::/ID397::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Л-21 / У "Four Dragons" (/gpshouse 397).
return
::/ID398::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Л-21 / У "Four Dragons" (/gpshouse 398).
return
::/ID399::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: К-21 / У "Four Dragons" (/gpshouse 399).
return
::/ID400::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: К-21 / У "Four Dragons" (/gpshouse 400).
return
::/ID401::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Л-21 / У "Four Dragons" (/gpshouse 401).
return
::/ID402::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Л-21 / У "Four Dragons" (/gpshouse 402).
return
::/ID403::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: К-21 / У "Four Dragons" (/gpshouse 403).
return
::/ID404::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: К-21 / У "Four Dragons" (/gpshouse 404).
return
::/ID405::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Л-21 / У "Four Dragons" (/gpshouse 405).
return
::/ID406::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Л-21 / У "Four Dragons" (/gpshouse 406).
return
::/ID407::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: К-21 / У "Four Dragons" (/gpshouse 407).
return
::/ID408::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: К-21 / У "Four Dragons" (/gpshouse 408).
return
::/ID409::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Л-21 / У "Four Dragons" (/gpshouse 409).
return
::/ID410::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Л-21 / У "Four Dragons" (/gpshouse 410).
return
::/ID411::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Л-21 / У "Four Dragons" (/gpshouse 411).
return
::/ID412::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Л-21 / У "Four Dragons" (/gpshouse 412).
return
::/ID413::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Л-22 / У "Four Dragons" (/gpshouse 413).
return
::/ID414::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Л-21 / У "Four Dragons" (/gpshouse 414).
return
::/ID415::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Л-21 / У "Four Dragons" (/gpshouse 415).
return
::/ID416::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Л-22 / У "Four Dragons" (/gpshouse 416).
return
::/ID417::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Л-21 / У "Four Dragons" (/gpshouse 417).
return
::/ID418::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Л-21 / У "Four Dragons" (/gpshouse 418).
return
::/ID419::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Л-21 / У "Four Dragons" (/gpshouse 419).
return
::/ID420::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Л-22 / У "Four Dragons" (/gpshouse 420).
return
::/ID421::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Л-22 / У "Four Dragons" (/gpshouse 421).
return
::/ID422::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Л-22 / У "Four Dragons" (/gpshouse 422).
return
::/ID423::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Л-22 / У "Four Dragons" (/gpshouse 423).
return
::/ID424::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Л-22 / У "Four Dragons" (/gpshouse 424).
return
::/ID425::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Л-22 / У "Four Dragons" (/gpshouse 425).
return
::/ID426::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Л-22 / У "Four Dragons" (/gpshouse 426).
return
::/ID427::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Л-22 / У "Four Dragons" (/gpshouse 427).
return
::/ID428::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Л-22 / У "Four Dragons" (/gpshouse 428).
return
::/ID429::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Л-22 / У "Four Dragons" (/gpshouse 429).
return
::/ID430::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Л-22 / У "Four Dragons" (/gpshouse 430).
return
::/ID431::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Л-22 / У "Four Dragons" (/gpshouse 431).
return
::/ID432::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Л-22 / У "Four Dragons" (/gpshouse 432).
return
::/ID433::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 500 000 | Квадрат: Л-22 / У "Four Dragons" (/gpshouse 433).
return
::/ID434::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Л-22 / У "Four Dragons" (/gpshouse 434).
return
::/ID435::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Л-22 / У "Four Dragons" (/gpshouse 435).
return
::/ID436::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Д-18 / У больницы ЛВ (/gpshouse 436).
return
::/ID437::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Д-18 / У больницы ЛВ (/gpshouse 437).
return
::/ID438::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Д-18 / У больницы ЛВ (/gpshouse 438).
return
::/ID439::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Д-18 / У больницы ЛВ (/gpshouse 439).
return
::/ID440::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Д-18 / У больницы ЛВ (/gpshouse 440).
return
::/ID441::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Д-18 / У больницы ЛВ (/gpshouse 441).
return
::/ID442::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 3 500 000 | Квадрат: Д-18 / У больницы ЛВ (/gpshouse 442).
return
::/ID443::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Д-18 / У больницы ЛВ (/gpshouse 443).
return
::/ID444::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Д-18 / У больницы ЛВ (/gpshouse 444).
return
::/ID445::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Д-18 / У больницы ЛВ (/gpshouse 445).
return
::/ID446::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Г-18 / У больницы ЛВ (/gpshouse 446).
return
::/ID447::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Г-18 / У больницы ЛВ (/gpshouse 447).
return
::/ID448::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Г-18 / У больницы ЛВ (/gpshouse 448).
return
::/ID449::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Г-18 / У больницы ЛВ (/gpshouse 449).
return
::/ID450::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Д-18 / У больницы ЛВ (/gpshouse 450).
return
::/ID451::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Д-18 / У больницы ЛВ (/gpshouse 451).
return
::/ID452::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Г-17 / У Russian Mafia (/gpshouse 452).
return
::/ID453::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Г-17 / У Russian Mafia (/gpshouse 453).
return
::/ID454::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Д-17 / У Russian Mafia (/gpshouse 454).
return
::/ID455::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Д-17 / У Russian Mafia (/gpshouse 455).
return
::/ID456::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Г-17 / У Russian Mafia (/gpshouse 456).
return
::/ID457::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Г-17 / У Russian Mafia (/gpshouse 457).
return
::/ID458::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Г-16 / У Russian Mafia (/gpshouse 458).
return
::/ID459::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Г-16 / У Russian Mafia (/gpshouse 459).
return
::/ID460::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Д-16 / У Russian Mafia (/gpshouse 460).
return
::/ID461::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Г-16 / У Russian Mafia (/gpshouse 461).
return
::/ID462::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 3 000 000 | Квадрат: Г-16 / У Russian Mafia (/gpshouse 462).
return
::/ID463::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 500 000 | Квадрат: Г-16 / У Russian Mafia (/gpshouse 463).
return
::/ID464::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Д-16 / У Russian Mafia (/gpshouse 464).
return
::/ID465::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Д-16 / У Russian Mafia (/gpshouse 465).
return
::/ID466::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Д-16 / У Russian Mafia (/gpshouse 466).
return
::/ID467::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Д-16 / У Russian Mafia (/gpshouse 467).
return
::/ID468::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Д-16 / У Russian Mafia (/gpshouse 468).
return
::/ID469::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Д-17 / У Russian Mafia (/gpshouse 469).
return
::/ID470::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Д-17 / У Russian Mafia (/gpshouse 470).
return
::/ID471::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 500 000 | Квадрат: Д-17 / У Russian Mafia (/gpshouse 471).
return
::/ID472::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Д-17 / У Russian Mafia (/gpshouse 472).
return
::/ID473::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 500 000 | Квадрат: Г-19 / У СТО ЛВ (/gpshouse 473).
return
::/ID474::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Г-19 / У СТО ЛВ (/gpshouse 474).
return
::/ID475::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 500 000 | Квадрат: Г-19 / У СТО ЛВ (/gpshouse 475).
return
::/ID476::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 500 000 | Квадрат: Г-19 / У СТО ЛВ (/gpshouse 476).
return
::/ID477::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Г-19 / У СТО ЛВ (/gpshouse 477).
return
::/ID478::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 500 000 | Квадрат: Г-19 / У СТО ЛВ (/gpshouse 478).
return
::/ID479::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Г-19 / У СТО ЛВ (/gpshouse 479).
return
::/ID480::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Г-19 / У СТО ЛВ (/gpshouse 480).
return
::/ID481::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Г-19 / У СТО ЛВ (/gpshouse 481).
return
::/ID482::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 500 000 | Квадрат: Г-19 / У СТО ЛВ (/gpshouse 482).
return
::/ID483::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 500 000 | Квадрат: Г-19 / У СТО ЛВ (/gpshouse 483).
return
::/ID484::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 500 000 | Квадрат: Г-19 / У СТО ЛВ (/gpshouse 484).
return
::/ID485::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Г-19 / У СТО ЛВ (/gpshouse 485).
return
::/ID486::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Г-19 / У СТО ЛВ (/gpshouse 486).
return
::/ID487::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 500 000 | Квадрат: Г-19 / У СТО ЛВ (/gpshouse 487).
return
::/ID488::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 500 000 | Квадрат: Г-19 / У СТО ЛВ (/gpshouse 488).
return
::/ID489::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 2 000 000 | Квадрат: Г-19 / У СТО ЛВ (/gpshouse 489).
return
::/ID490::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 200 000 | Квадрат: Ф-23 / У Grove (/gpshouse 490).
return
::/ID491::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 3 000 000 | Квадрат: O-22 / Посёлок "Sobrino" (/gpshouse 491).
return
::/ID492::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 3 000 000 | Квадрат: O-22 / Посёлок "Sobrino" (/gpshouse 492).
return
::/ID493::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 3 000 000 | Квадрат: O-22 / Посёлок "Sobrino" (/gpshouse 493).
return
::/ID494::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 15 000 000 | Квадрат: O-21 / Посёлок "Sobrino" (/gpshouse 494).
return
::/ID495::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 3 000 000 | Квадрат: O-21 / Посёлок "Sobrino" (/gpshouse 495).
return
::/ID496::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 3 000 000 | Квадрат: O-21 / Посёлок "Sobrino" (/gpshouse 496).
return
::/ID497::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 4 000 000 | Квадрат: Х-13 / Пляж Санта-Мария (/gpshouse 497).
return
::/ID498::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 600 000 | Квадрат: Ф-20 / У заправки в гетто (/gpshouse 498).
return
::/ID499::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 000 000 | Квадрат: O-2 / Муравейник (/gpshouse 499).
return
::/ID500::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 400 000 | Квадрат: O-2 / Муравейник (/gpshouse 500).
return
::/ID501::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 700 000 | Квадрат: O-2 / Муравейник (/gpshouse 501).
return
::/ID502::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: O-2 / Муравейник (/gpshouse 502).
return
::/ID503::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 350 000 | Квадрат: O-2 / Муравейник (/gpshouse 503).
return
::/ID504::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 500 000 | Квадрат: O-2 / Муравейник (/gpshouse 504).
return
::/ID505::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 700 000 | Квадрат: O-2 / Муравейник (/gpshouse 505).
return
::/ID506::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 2 000 000 | Квадрат: O-2 / Муравейник (/gpshouse 506).
return
::/ID507::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 2 000 000 | Квадрат: О-1 / Муравейник (/gpshouse 507).
return
::/ID508::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: О-1 / Муравейник (/gpshouse 508).
return
::/ID509::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 400 000 | Квадрат: О-1 / Муравейник (/gpshouse 509).
return
::/ID510::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 000 000 | Квадрат: О-1 / Муравейник (/gpshouse 510).
return
::/ID511::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 300 000 | Квадрат: О-1 / Муравейник (/gpshouse 511).
return
::/ID512::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 700 000 | Квадрат: О-1 / Муравейник (/gpshouse 512).
return
::/ID513::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: О-1 / Муравейник (/gpshouse 513).
return
::/ID514::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 300 000 | Квадрат: О-1 / Муравейник (/gpshouse 514).
return
::/ID515::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: О-1 / Муравейник (/gpshouse 515).
return
::/ID516::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 000 000 | Квадрат: О-1 / Муравейник (/gpshouse 516).
return
::/ID517::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 2 000 000 | Квадрат: О-1 / Муравейник (/gpshouse 517).
return
::/ID518::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 3 000 000 | Квадрат: Л-1 / Сан-Фиерро (/gpshouse 518).
return
::/ID519::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 3 000 000 | Квадрат: Л-1 / Сан-Фиерро (/gpshouse 519).
return
::/ID520::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 3 000 000 | Квадрат: Л-1 / Сан-Фиерро (/gpshouse 520).
return
::/ID521::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 3 000 000 | Квадрат: И-1 / У Jizzy (/gpshouse 521).
return
::/ID522::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 3 000 000 | Квадрат: И-1 / У Jizzy (/gpshouse 522).
return
::/ID523::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 3 000 000 | Квадрат: И-1 / У Jizzy (/gpshouse 523).
return
::/ID524::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 100 000 | Квадрат: T-22 / Гетто (/gpshouse 524).
return
::/ID525::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 100 000 | Квадрат: T-22 / Гетто (/gpshouse 525).
return
::/ID526::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 300 000 | Квадрат: T-22 / Гетто (/gpshouse 526).
return
::/ID527::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 300 000 | Квадрат: T-21 / Гетто (/gpshouse 527).
return
::/ID528::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 300 000 | Квадрат: T-21 / Гетто (/gpshouse 528).
return
::/ID529::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 100 000 | Квадрат: C-21 / Гетто (/gpshouse 529).
return
::/ID530::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 130 000 | Квадрат: C-21 / Гетто (/gpshouse 530).
return
::/ID531::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 140 000 | Квадрат: T-21 / Гетто (/gpshouse 531).
return
::/ID532::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 130 000 | Квадрат: C-21 / Гетто (/gpshouse 532).
return
::/ID533::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 130 000 | Квадрат: C-21 / Гетто (/gpshouse 533).
return
::/ID534::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 300 000 | Квадрат: C-21 / Гетто (/gpshouse 534).
return
::/ID535::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 200 000 | Квадрат: C-21 / Гетто (/gpshouse 535).
return
::/ID536::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 200 000 | Квадрат: C-21 / Гетто (/gpshouse 536).
return
::/ID537::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 300 000 | Квадрат: C-21 / Гетто (/gpshouse 537).
return
::/ID538::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 300 000 | Квадрат: C-21 / Гетто (/gpshouse 538).
return
::/ID539::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 340 000 | Квадрат: C-21 / Гетто (/gpshouse 539).
return
::/ID540::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 440 000 | Квадрат: C-21 / Гетто (/gpshouse 540).
return
::/ID541::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: C-21 / Гетто (/gpshouse 541).
return
::/ID542::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 400 000 | Квадрат: Х-22 / У Rifa (/gpshouse 542).
return
::/ID543::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 400 000 | Квадрат: Х-22 / У Rifa (/gpshouse 543).
return
::/ID544::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 400 000 | Квадрат: Х-22 / У Rifa (/gpshouse 544).
return
::/ID545::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 400 000 | Квадрат: Х-22 / У Rifa (/gpshouse 545).
return
::/ID546::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 400 000 | Квадрат: Х-22 / У Rifa (/gpshouse 546).
return
::/ID547::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 400 000 | Квадрат: Х-22 / У Rifa (/gpshouse 547).
return
::/ID548::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 400 000 | Квадрат: Х-22 / У Rifa (/gpshouse 548).
return
::/ID549::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 400 000 | Квадрат: Х-21 / У Rifa (/gpshouse 549).
return
::/ID550::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 150 000 | Квадрат: T-21 / У отеля Jefferson (/gpshouse 550).
return
::/ID551::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 150 000 | Квадрат: T-21 / У отеля Jefferson (/gpshouse 551).
return
::/ID552::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 120 000 | Квадрат: T-21 / У отеля Jefferson (/gpshouse 552).
return
::/ID553::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 160 000 | Квадрат: T-21 / У отеля Jefferson (/gpshouse 553).
return
::/ID554::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 200 000 | Квадрат: T-21 / У отеля Jefferson (/gpshouse 554).
return
::/ID555::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 200 000 | Квадрат: T-21 / У отеля Jefferson (/gpshouse 555).
return
::/ID556::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 150 000 | Квадрат: T-21 / У отеля Jefferson (/gpshouse 556).
return
::/ID557::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [N] | Цена: 120 000 | Квадрат: T-21 / У отеля Jefferson (/gpshouse 557).
return
::/ID558::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 400 000 | Квадрат: T-21 / У отеля Jefferson (/gpshouse 558).
return
::/ID559::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 400 000 | Квадрат: T-21 / У отеля Jefferson (/gpshouse 559).
return
::/ID560::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 6 000 000 | Квадрат: К-10 / У Форт-Карсона (/gpshouse 560).
return
::/ID561::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 3 000 000 | Квадрат: B-6 / El Guebrabos (/gpshouse 561).
return
::/ID562::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [S] | Цена: 25 000 000 | Квадрат: C-18 / VineWood (/gpshouse 562).
return
::/ID563::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 2 000 000 | Квадрат: У-13 / VineWood (/gpshouse 563).
return
::/ID564::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [S] | Цена: 25 000 000 | Квадрат: У-13 / VineWood (/gpshouse 564).
return
::/ID565::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 20 000 000 | Квадрат: У-13 / VineWood (/gpshouse 565).
return
::/ID566::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 8 000 500 | Квадрат: Б-19 / У Yakuza (/gpshouse 566).
return
::/ID567::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [S] | Цена: 25 000 000 | Квадрат: Б-19 / У Yakuza (/gpshouse 567).
return
::/ID568::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Данного дома на 02 сервере нет.
return
::/ID569::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Данного дома на 02 сервере нет.
return
::/ID570::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Данного дома на 02 сервере нет.
return
::/ID571::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 000 000 | Квадрат: O-2 / Муравейник (/gpshouse 571).
return
::/ID572::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: O-2 / Муравейник (/gpshouse 572).
return
::/ID573::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 700 000 | Квадрат: O-2 / Муравейник (/gpshouse 573).
return
::/ID574::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 000 000 | Квадрат: O-2 / Муравейник (/gpshouse 574).
return
::/ID575::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 000 000 | Квадрат: O-2 / Муравейник (/gpshouse 575).
return
::/ID576::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 000 000 | Квадрат: Н-2 / Муравейник (/gpshouse 576).
return
::/ID577::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 000 000 | Квадрат: Н-2 / Муравейник (/gpshouse 577).
return
::/ID578::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 000 000 | Квадрат: Н-2 / Муравейник (/gpshouse 578).
return
::/ID579::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 000 000 | Квадрат: Н-2 / Муравейник (/gpshouse 579).
return
::/ID580::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 000 000 | Квадрат: Н-2 / Муравейник (/gpshouse 580).
return
::/ID581::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 000 000 | Квадрат: Н-2 / Муравейник (/gpshouse 581).
return
::/ID582::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 000 000 | Квадрат: Н-2 / Муравейник (/gpshouse 582).
return
::/ID583::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 000 000 | Квадрат: Н-2 / Муравейник (/gpshouse 583).
return
::/ID584::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 000 000 | Квадрат: Н-2 / Муравейник (/gpshouse 584).
return
::/ID585::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 000 000 | Квадрат: Н-2 / Муравейник (/gpshouse 585).
return
::/ID586::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 000 000 | Квадрат: Н-2 / Муравейник (/gpshouse 586).
return
::/ID587::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 000 000 | Квадрат: Н-2 / Муравейник (/gpshouse 587).
return
::/ID588::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 2 500 000 | Квадрат: Н-2 / Муравейник (/gpshouse 588).
return
::/ID589::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 000 000 | Квадрат: Н-2 / Муравейник (/gpshouse 589).
return
::/ID590::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 000 000 | Квадрат: Н-2 / Муравейник (/gpshouse 590).
return
::/ID591::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 000 000 | Квадрат: Н-2 / Муравейник (/gpshouse 591).
return
::/ID592::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 000 000 | Квадрат: Н-2 / Муравейник (/gpshouse 592).
return
::/ID593::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 2 500 000 | Квадрат: Н-2 / Муравейник (/gpshouse 593).
return
::/ID594::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 000 000 | Квадрат: О-1 / Муравейник (/gpshouse 594).
return
::/ID595::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 000 000 | Квадрат: О-1 / Муравейник (/gpshouse 595).
return
::/ID596::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 000 000 | Квадрат: О-1 / Муравейник (/gpshouse 596).
return
::/ID597::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 000 000 | Квадрат: О-1 / Муравейник (/gpshouse 597).
return
::/ID598::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 000 000 | Квадрат: О-1 / Муравейник (/gpshouse 598).
return
::/ID599::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 000 000 | Квадрат: Н-1 / Муравейник (/gpshouse 599).
return
::/ID600::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 000 000 | Квадрат: Н-1 / Муравейник (/gpshouse 600).
return
::/ID601::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 000 000 | Квадрат: Н-1 / Муравейник (/gpshouse 601).
return
::/ID602::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 000 000 | Квадрат: Н-1 / Муравейник (/gpshouse 602).
return
::/ID603::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: Н-1 / Муравейник (/gpshouse 603).
return
::/ID604::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: Н-1 / Муравейник (/gpshouse 604).
return
::/ID605::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: Х-21 / У Rifa (/gpshouse 605).
return
::/ID606::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: Х-22 / У Willowfield (/gpshouse 606).
return
::/ID607::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: Х-22 / У Willowfield (/gpshouse 607).
return
::/ID608::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: Х-21 / У Rifa (/gpshouse 608).
return
::/ID609::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: Х-22 / У Willowfield (/gpshouse 609).
return
::/ID610::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: Х-22 / У Willowfield (/gpshouse 610).
return
::/ID611::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: Х-22 / У Willowfield (/gpshouse 611).
return
::/ID612::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: Х-22 / У Willowfield (/gpshouse 612).
return
::/ID613::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 650 000 | Квадрат: Х-23 / У Ballas (/gpshouse 613).
return
::/ID614::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 650 000 | Квадрат: Х-23 / У Ballas (/gpshouse 614).
return
::/ID615::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 650 000 | Квадрат: Х-24 / У Ballas (/gpshouse 615).
return
::/ID616::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 650 000 | Квадрат: Х-24 / У Ballas (/gpshouse 616).
return
::/ID617::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 650 000 | Квадрат: Х-24 / У Ballas (/gpshouse 617).
return
::/ID618::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 650 000 | Квадрат: Х-24 / У Balla (/gpshouse 618).
return
::/ID619::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 650 000 | Квадрат: Х-24 / У Ballas (/gpshouse 619).
return
::/ID620::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 650 000 | Квадрат: Х-24 / У Ballas (/gpshouse 620).
return
::/ID621::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 2 500 000 | Квадрат: T-24 / В гетто у горы (/gpshouse 621).
return
::/ID622::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 500 000 | Квадрат: T-24 / В гетто у горы (/gpshouse 622).
return
::/ID623::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 500 000 | Квадрат: T-24 / В гетто у горы (/gpshouse 623).
return
::/ID624::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 500 000 | Квадрат: T-24 / В гетто у горы (/gpshouse 624).
return
::/ID625::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 000 000 | Квадрат: У-24/T-24 / В гетто у горы (/gpshouse 625).
return
::/ID626::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 000 000 | Квадрат: У-24/T-24 / В гетто у горы (/gpshouse 626).
return
::/ID627::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 000 000 | Квадрат: У-24 / В гетто у горы (/gpshouse 627).
return
::/ID628::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 000 000 | Квадрат: У-24 / В гетто у горы (/gpshouse 628).
return
::/ID629::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 000 000 | Квадрат: У-24 / В гетто у горы (/gpshouse 629).
return
::/ID630::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 000 000 | Квадрат: У-24 / В гетто у горы (/gpshouse 630).
return
::/ID631::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 000 000 | Квадрат: У-24 / В гетто у горы (/gpshouse 631).
return
::/ID632::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 000 000 | Квадрат: У-24 / В гетто у горы (/gpshouse 632).
return
::/ID633::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 000 000 | Квадрат: У-24 / В гетто у горы (/gpshouse 633).
return
::/ID634::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 450 000 | Квадрат: T-23 / В гетто у горы (/gpshouse 634).
return
::/ID635::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 450 000 | Квадрат: T-23 / В гетто у горы (/gpshouse 635).
return
::/ID636::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 450 000 | Квадрат: T-22 / В гетто у горы (/gpshouse 636).
return
::/ID637::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 450 000 | Квадрат: T-22 / В гетто у горы (/gpshouse 637).
return
::/ID638::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 450 000 | Квадрат: T-22 / В гетто у горы (/gpshouse 638).
return
::/ID639::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 450 000 | Квадрат: T-23 / В гетто у горы (/gpshouse 639).
return
::/ID640::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 450 000 | Квадрат: T-23 / В гетто у горы (/gpshouse 640).
return
::/ID641::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 450 000 | Квадрат: T-23 / В гетто у горы (/gpshouse 641).
return
::/ID642::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 15 000 000 | Квадрат: P-16 / VineWood (/gpshouse 642).
return
::/ID643::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 250 000 | Квадрат: O-14 / У фермы №3 (/gpshouse 643).
return
::/ID644::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 250 000 | Квадрат: O-14 / У фермы №3 (/gpshouse 644).
return
::/ID645::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 250 000 | Квадрат: O-14 / У фермы №3 (/gpshouse 645).
return
::/ID646::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 250 000 | Квадрат: O-14 / У фермы №3 (/gpshouse 646).
return
::/ID647::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 250 000 | Квадрат: O-14 / У фермы №3 (/gpshouse 647).
return
::/ID648::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 250 000 | Квадрат: O-14 / У фермы №3 (/gpshouse 648).
return
::/ID649::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 250 000 | Квадрат: P-15 / Dillimore (/gpshouse 649).
return
::/ID650::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 250 000 | Квадрат: P-15 / Dillimore (/gpshouse 650).
return
::/ID651::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 250 000 | Квадрат: P-15 / Dillimore (/gpshouse 651).
return
::/ID652::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 250 000 | Квадрат: P-16 / Dillimore (/gpshouse 652).
return
::/ID653::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 250 000 | Квадрат: P-16 / Dillimore (/gpshouse 653).
return
::/ID654::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 250 000 | Квадрат: P-16 / Dillimore (/gpshouse 654).
return
::/ID655::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 250 000 | Квадрат: P-16 / Dillimore (/gpshouse 655).
return
::/ID656::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 250 000 | Квадрат: Н-21 / Посёлок "Sobrino" (/gpshouse 656).
return
::/ID657::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 250 000 | Квадрат: Н-21 / Посёлок "Sobrino" (/gpshouse 657).
return
::/ID658::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 250 000 | Квадрат: Н-21 / Посёлок "Sobrino" (/gpshouse 658).
return
::/ID659::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 250 000 | Квадрат: Н-22 / Посёлок "Sobrino" (/gpshouse 659).
return
::/ID660::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 250 000 | Квадрат: Н-22 / Посёлок "Sobrino" (/gpshouse 660).
return
::/ID661::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 250 000 | Квадрат: Н-21 / Посёлок "Sobrino" (/gpshouse 661).
return
::/ID662::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 250 000 | Квадрат: Н-21 / Посёлок "Sobrino" (/gpshouse 662).
return
::/ID663::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 3 000 000 | Квадрат: O-21 / Посёлок "Sobrino" (/gpshouse 663).
return
::/ID664::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 3 000 000 | Квадрат: O-22 / Посёлок "Sobrino" (/gpshouse 664).
return
::/ID665::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 3 000 000 | Квадрат: O-21 / Посёлок "Sobrino" (/gpshouse 665).
return
::/ID666::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 250 000 | Квадрат: Н-22 / Посёлок "Sobrino" (/gpshouse 666).
return
::/ID667::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 250 000 | Квадрат: Н-22 / Посёлок "Sobrino" (/gpshouse 667).
return
::/ID668::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 250 000 | Квадрат: Н-22 / Посёлок "Sobrino" (/gpshouse 668).
return
::/ID669::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 250 000 | Квадрат: Н-22 / Посёлок "Sobrino" (/gpshouse 669).
return
::/ID670::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 250 000 | Квадрат: Н-22 / Посёлок "Sobrino" (/gpshouse 670).
return
::/ID671::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 250 000 | Квадрат: Н-22 / Посёлок "Sobrino" (/gpshouse 671).
return
::/ID672::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 250 000 | Квадрат: Н-22 / Посёлок "Sobrino" (/gpshouse 672).
return
::/ID673::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 250 000 | Квадрат: Н-22 / Посёлок "Sobrino" (/gpshouse 673).
return
::/ID674::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 250 000 | Квадрат: O-22 / Посёлок "Sobrino" (/gpshouse 674).
return
::/ID675::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 250 000 | Квадрат: O-22 / Посёлок "Sobrino" (/gpshouse 675).
return
::/ID676::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 250 000 | Квадрат: O-22 / Посёлок "Sobrino" (/gpshouse 676).
return
::/ID677::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 250 000 | Квадрат: O-22 / Посёлок "Sobrino" (/gpshouse 677).
return
::/ID678::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 250 000 | Квадрат: O-22 / Посёлок "Sobrino" (/gpshouse 678).
return
::/ID679::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 250 000 | Квадрат: O-22 / Посёлок "Sobrino" (/gpshouse 679).
return
::/ID680::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 250 000 | Квадрат: O-22 / Посёлок "Sobrino" (/gpshouse 680).
return
::/ID681::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 250 000 | Квадрат: Н-22 / Посёлок "Sobrino" (/gpshouse 681).
return
::/ID682::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 250 000 | Квадрат: Н-22 / Посёлок "Sobrino" (/gpshouse 682).
return
::/ID683::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 250 000 | Квадрат: Н-22 / Посёлок "Sobrino" (/gpshouse 683).
return
::/ID684::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 250 000 | Квадрат: Н-22 / Посёлок "Sobrino" (/gpshouse 684).
return
::/ID685::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 250 000 | Квадрат: Н-22 / Посёлок "Sobrino" (/gpshouse 685).
return
::/ID686::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 250 000 | Квадрат: Н-22 / Посёлок "Sobrino" (/gpshouse 686).
return
::/ID687::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 250 000 | Квадрат: Н-22 / Посёлок "Sobrino" (/gpshouse 687).
return
::/ID688::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 250 000 | Квадрат: Н-22 / Посёлок "Sobrino" (/gpshouse 688).
return
::/ID689::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 250 000 | Квадрат: Н-22 / Посёлок "Sobrino" (/gpshouse 689).
return
::/ID690::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 250 000 | Квадрат: Н-22 / Посёлок "Sobrino" (/gpshouse 690).
return
::/ID691::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 250 000 | Квадрат: Н-23 / Посёлок "Sobrino" (/gpshouse 691).
return
::/ID692::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 250 000 | Квадрат: Н-23 / Посёлок "Sobrino" (/gpshouse 692).
return
::/ID693::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 250 000 | Квадрат: Н-23 / Посёлок "Sobrino" (/gpshouse 693).
return
::/ID694::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 250 000 | Квадрат: Н-23 / Посёлок "Sobrino" (/gpshouse 694).
return
::/ID695::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 250 000 | Квадрат: Н-23 / Посёлок "Sobrino" (/gpshouse 695).
return
::/ID696::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 250 000 | Квадрат: O-23 / Посёлок "Sobrino" (/gpshouse 696).
return
::/ID697::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 250 000 | Квадрат: O-23 / Посёлок "Sobrino" (/gpshouse 697).
return
::/ID698::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 250 000 | Квадрат: O-22 / Посёлок "Sobrino" (/gpshouse 698).
return
::/ID699::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 250 000 | Квадрат: Н-22 / Посёлок "Sobrino" (/gpshouse 699).
return
::/ID700::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 250 000 | Квадрат: Н-22 / Посёлок "Sobrino" (/gpshouse 700).
return
::/ID701::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 250 000 | Квадрат: Н-22 / Посёлок "Sobrino" (/gpshouse 701).
return
::/ID702::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 250 000 | Квадрат: Н-23 / Посёлок "Sobrino" (/gpshouse 702).
return
::/ID703::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 250 000 | Квадрат: Н-23 / Посёлок "Sobrino" (/gpshouse 703).
return
::/ID704::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 000 000 | Квадрат: Н-1 / Муравейник (/gpshouse 704).
return
::/ID705::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 000 000 | Квадрат: Н-1 / Муравейник (/gpshouse 705).
return
::/ID706::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 000 000 | Квадрат: Н-1 / Муравейник (/gpshouse 706).
return
::/ID707::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 000 000 | Квадрат: Н-1 / Муравейник (/gpshouse 707).
return
::/ID708::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 000 000 | Квадрат: Н-1 / Муравейник (/gpshouse 708).
return
::/ID709::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 2 500 000 | Квадрат: Н-1 / Муравейник (/gpshouse 709).
return
::/ID710::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 000 000 | Квадрат: Н-1 / Муравейник (/gpshouse 710).
return
::/ID711::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 000 000 | Квадрат: Н-1 / Муравейник (/gpshouse 711).
return
::/ID712::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 000 000 | Квадрат: Н-1 / Муравейник (/gpshouse 712).
return
::/ID713::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 000 000 | Квадрат: Н-1 / Муравейник (/gpshouse 713).
return
::/ID714::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 2 500 000 | Квадрат: Н-2 / У АММО СФ (/gpshouse 714).
return
::/ID715::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 000 000 | Квадрат: Н-2 / У АММО СФ (/gpshouse 715).
return
::/ID716::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 000 000 | Квадрат: Н-2 / У АММО СФ (/gpshouse 716).
return
::/ID717::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 000 000 | Квадрат: Н-2 / У АММО СФ (/gpshouse 717).
return
::/ID718::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 000 000 | Квадрат: Н-2 / У АММО СФ (/gpshouse 718).
return
::/ID719::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 000 000 | Квадрат: Н-2 / У АММО СФ (/gpshouse 719).
return
::/ID720::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 2 500 000 | Квадрат: Н-2 / У АММО СФ (/gpshouse 720).
return
::/ID721::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 000 000 | Квадрат: Н-2 / У АММО СФ (/gpshouse 721).
return
::/ID722::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 000 000 | Квадрат: Н-2 / У АММО СФ (/gpshouse 722).
return
::/ID723::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 000 000 | Квадрат: Ш-4 / Angel Pine (/gpshouse 723).
return
::/ID724::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 000 000 | Квадрат: Ш-4 / Angel Pine (/gpshouse 724).
return
::/ID725::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 000 000 | Квадрат: Ш-4 / Angel Pine (/gpshouse 725).
return
::/ID726::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 000 000 | Квадрат: Ч-4 / Angel Pine (/gpshouse 726).
return
::/ID727::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 000 000 | Квадрат: Ч-4 / Angel Pine (/gpshouse 727).
return
::/ID728::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 000 000 | Квадрат: Ч-4 / Angel Pine (/gpshouse 728).
return
::/ID729::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 000 000 | Квадрат: Ч-4 / Angel Pine (/gpshouse 729).
return
::/ID730::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 000 000 | Квадрат: Ч-4 / Angel Pine (/gpshouse 730).
return
::/ID731::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [C] | Цена: 1 000 000 | Квадрат: Ш-4 / Angel Pine (/gpshouse 731).
return
::/ID732::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 400 000 | Квадрат: Ш-4 / Angel Pine (/gpshouse 732).
return
::/ID733::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 400 000 | Квадрат: Ш-4 / Angel Pine (/gpshouse 733).
return
::/ID734::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 400 000 | Квадрат: Ш-4 / Angel Pine (/gpshouse 734).
return
::/ID735::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 400 000 | Квадрат: Ш-4 / Angel Pine (/gpshouse 735).
return
::/ID736::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 400 000 | Квадрат: Ш-4 / Angel Pine (/gpshouse 736).
return
::/ID737::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 400 000 | Квадрат: Ш-4 / Angel Pine (/gpshouse 737).
return
::/ID738::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 400 000 | Квадрат: Ш-4 / Angel Pine (/gpshouse 738).
return
::/ID739::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 400 000 | Квадрат: Ш-4 / Angel Pine (/gpshouse 739).
return
::/ID740::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 400 000 | Квадрат: Ш-4 / Angel Pine (/gpshouse 740).
return
::/ID741::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 400 000 | Квадрат: Ш-4 / Angel Pine (/gpshouse 741).
return
::/ID742::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 400 000 | Квадрат: Ш-4 / Angel Pine (/gpshouse 742).
return
::/ID743::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 400 000 | Квадрат: Ш-4 / Angel Pine (/gpshouse 743).
return
::/ID744::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 2 000 000 | Квадрат: Ч-4 / Angel Pine (/gpshouse 744).
return
::/ID745::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: M-16 / (/gpshouse 745).
return
::/ID746::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: M-16 / (/gpshouse 746).
return
::/ID747::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: M-16 / (/gpshouse 747).
return
::/ID748::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: M-16 / (/gpshouse 748).
return
::/ID749::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: M-15 / (/gpshouse 749).
return
::/ID750::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: M-15 / (/gpshouse 750).
return
::/ID751::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: M-15 / (/gpshouse 751).
return
::/ID752::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: M-15 / (/gpshouse 752).
return
::/ID753::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: M-15 / (/gpshouse 753).
return
::/ID754::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: M-15 / (/gpshouse 754).
return
::/ID755::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: Н-14 / У фермы №3 (/gpshouse 755).
return
::/ID756::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: Н-14 / У фермы №3 (/gpshouse 756).
return
::/ID757::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: Н-14 / У фермы №3 (/gpshouse 757).
return
::/ID758::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: Н-14 / У фермы №3 (/gpshouse 758).
return
::/ID759::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: Н-14 / У фермы №3 (/gpshouse 759).
return
::/ID760::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: Н-14 / У фермы №3 (/gpshouse 760).
return
::/ID761::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [B] | Цена: 4 000 000 | Квадрат: И-11 / Форт-Карсон (/gpshouse 761).
return
::/ID762::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 000 000 | Квадрат: И-11 / Форт-Карсон (/gpshouse 762).
return
::/ID763::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 000 000 | Квадрат: И-11 / Форт-Карсон (/gpshouse 763).
return
::/ID764::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 000 000 | Квадрат: И-11 / Форт-Карсон (/gpshouse 764).
return
::/ID765::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 000 000 | Квадрат: И-11 / Форт-Карсон (/gpshouse 765).
return
::/ID766::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 000 000 | Квадрат: И-11 / Форт-Карсон (/gpshouse 766).
return
::/ID767::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 000 000 | Квадрат: И-11 / Форт-Карсон (/gpshouse 767).
return
::/ID768::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 000 000 | Квадрат: И-11 / Форт-Карсон (/gpshouse 768).
return
::/ID769::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 000 000 | Квадрат: И-11 / Форт-Карсон (/gpshouse 769).
return
::/ID770::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 000 000 | Квадрат: И-11 / Форт-Карсон (/gpshouse 770).
return
::/ID771::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 000 000 | Квадрат: И-11 / Форт-Карсон (/gpshouse 771).
return
::/ID772::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 000 000 | Квадрат: И-11 / Форт-Карсон (/gpshouse 772).
return
::/ID773::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 000 000 | Квадрат: И-11 / Форт-Карсон (/gpshouse 773).
return
::/ID774::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [С] | Цена: 1 000 000 | Квадрат: И-11 / Форт-Карсон (/gpshouse 774).
return
::/ID775::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [S] | Цена: 25 000 000 | Квадрат: У-14 / VineWood (/gpshouse 775).
return
::/ID776::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 10 000 000 | Квадрат: Б-19 / У Yakuza (/gpshouse 776).
return
::/ID777::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 10 000 000 | Квадрат: Б-19 / У Yakuza (/gpshouse 777).
return
::/ID778::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [A] | Цена: 10 000 000 | Квадрат: Б-19 / У Yakuza (/gpshouse 778).
return
::/ID779::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: А-12 / У заброшенного Аэро (/gpshouse 779).
return
::/ID780::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: А-11 / У заброшенного Аэро (/gpshouse 780).
return
::/ID781::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: А-11 / У заброшенного Аэро (/gpshouse 781).
return
::/ID782::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: А-11 / У заброшенного Аэро (/gpshouse 782).
return
::/ID783::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: Б-11 / У заброшенного Аэро (/gpshouse 783).
return
::/ID784::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: Б-11 / У заброшенного Аэро (/gpshouse 784).
return
::/ID785::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: Б-11 / У заброшенного Аэро (/gpshouse 785).
return
::/ID786::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: А-12 / У заброшенного Аэро (/gpshouse 786).
return
::/ID787::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: А-12 / У заброшенного Аэро (/gpshouse 787).
return
::/ID788::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: Б-12 / У заброшенного Аэро (/gpshouse 788).
return
::/ID789::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: Б-12 / У заброшенного Аэро (/gpshouse 789).
return
::/ID790::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [D] | Цена: 500 000 | Квадрат: Б-12 / У заброшенного Аэро (/gpshouse 790).
return
::/ID791::
SendMessage, 0x50,, 0x4190419,, A
sendinput,Класс [S] | Цена: 25 000 000 | Квадрат: Ч-4 / Angel Pine (/gpshouse 791).
return