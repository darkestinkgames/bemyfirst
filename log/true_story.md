
## день перший <sup>(11.8.2022)</sup>

хз з чого почати) нашвидкоруч намалював карту, Tiled у поміч<br />
завелика вдалась, не розрахував, і переробляти ліньки<br />
хоча для прототипу норм<br />
хіба що спрайти дрібні як блохи (бо ж на холяву з інету)<br />
може спробую намалювати власні колись (але це не точно)

## день другий—п’ятий <sup>(від 12.8.2022)</sup>

спробував пописати диз.доки, хз як їх роблять<br />
опсав трохи статів для загонів і тайлів, щось ще<br />
було натхнення, зникло натхнення) напсав трохи коду

написав трохи коду, щоб спрайти руцями не завантажувати<br />
навіть з метатаблицями трохи розібрався, мабуть<br />
тепер маю глобальну змінну Sprite:<br />
і завантажує, і обробляє, і кадри повертає<br />
ще й усе робиться однією функцією **Sprite()**<br />
зручно :)

замислився над розрахунками тайлів (або чарунків, може)<br />
прописати вартість для кожного загону окремо? і це для кожного окремого тайлу!<br />
і сподіватися, що нічого ніде не прогавлю)<br />
або задати вхідні дані та навантажити розрахунками<br />
як проц, так і гравця...

зрозумів, що туплю (та не вмію добре планувати, шкода)<br />
зробив вхідні дані, і щоб воно само розрахувало усю вартість<br />
так вийшло більше клопоту з кодом, однак тепер меньше шансів на помилку з неуважності<br />
ну а що гравцю показати — це вже потім вигадаю

помудохався з lua-кодом карти, наче працює<br />
прописав маштабування, щоб карта завжди влізала в екран (тимчасовий костиль)<br />
ще перемикач вікно / повноекранний режим на F4<br />
зробив днів за два-три, хз — так захопився процесом, що занотовувати забув та й ліньки

і ще десь у цьому проміжку розписав код, що виводить і нумерує усі тайли<br />
заскрінив та зберіг, щоб легше було прописувати<br />
пишаюсь собою :)

помітив проблему:<br />
шрифт втрачає зглажування, якщо у повноекранному режимі

намагався зібрати екзе’шник<br />
затуп №1: зробив архів .7z замість .zip, недогледів<br />
через це "картридж" (.love-файл) довго відкривався, а конвертуватися й взагалі не схтів<br />
затуп №2: не можна конвертуватися в екзе, якщо у папці Program Files<br />
довелося переміщатися у Мої док-и

дописав карту<br />
тепр кожна чарунка — це не просто картинка, а готовий до роботи набір даних<br />
дописав курсор миші — тепер відображає координату і назву чарунки під курсором<br />
радість :)

збільшив у 4 рази, 64 пікселі спрайт, ніби непогано, прикріплю скрін <br />
(або хочаб спробую)<br />
на такий розмір і буду орієнтуватися

порахував, наче минуло десь днів п’ять<br />
ну як днів: коли вечорів, коли ранків %)<br />
щоб аж цілий день над кодом пріти — змоги немає, життя

![true story.jpg](true_story.jpg)


## день 6–7 <sup>(від 16.8.2022)</sup>

накидав приблизну перезарядку дій<br />
це щоб не можна було двічи за хід пересуватися, наприклад<br />
або щоб можна було, побачимо)

підійшов до реалізації пошуку шляхів<br />
маю декілька ідей, не маю достатньо часу<br />
наразі лише розумію, що за хід буду прораховувати усі чарунки<br />
заради інтерфейсу та Ш.І., ну типу Ш.І. :D

згадалася Tactics Ogre, там фіча була:<br />
коли тайл заскладний для проходження, перс може його перестрибнути<br />
тепер цікаво, як там було реалізовано пошук шляху<br />
хоча, відволікся

що там ще? оновився по фреймворку до 11.4<br />
переписав купу коду<br />
здувся вести нотатки)


## день 8 <sup>(18.8.2022)</sup>

написав маленьку, але дуже корисну функцію<br />
розраховує вартість входження

```Lua
function getMapCost(unit, cell)
        local impass = 15
        if not cell.data.vartist[unit.move.id] then
                cell.data.vartist[unit.move.id] = unit.move.lvl > cell.data[unit.move.typ].lvl
                and math.max(1, cell.data[unit.move.typ].pass - unit.move.pass)
                or impass
        end
        local vartist = cell.data.vartist[unit.move.id]
        if cell.unit then
                vartist = unit.team == cell.unit.team and vartist or impass
        end
        return vartist
end
```

лишилося ще одну, приблизно таку

створю порожній масив на перевірку<br />
додам туди стартову чарунку (місцезнаходження юніта)<br />
і далі по циклу<br />
якщо вартість входу сусідньої чарунки або відсутня, або має більше значення<br />
у вартості шляху вказую розраховане значення, а чарунку додаю на перевірку

виглядає не складно<br />
лишилося прописати

## день 9 <sup>(19.8.2022)</sup>

прописав, хоч і з помилками) основна маса з яких — невірно вказаний ключ до змінної<br />
по пам’яті писати — таке собі, щоправда у vs code коментарі допомогають<br />
тілько хз де цю тему прошарити

все виправив, працює, лишилося іще одну функцію<br />
буде брати вказану чарунку та шукати найменшу вартість шляху серед сусідніх чарунок<br />
власне кажучі, це і все — з пошуком шляху розібрався

![true story 2.png](true_story_2.jpg)

далі мабуть навчу юнітів ходити


## день 10 <sup>(20.8.2022)</sup>

трошки пописав коду на відображення поля пересування


## день 11 <sup>(21.8.2022)</sup>

трохи прошарив ту фіговину у vs code<br />
називалося анотаціями, ось так просто)<br />
дуууже корисна штука


## день 12 <sup>(22.8.2022)</sup>

етап: від розуміння до застосування<br />
засрав увесь код анотаціями)<br />
схоже, що доведеться усе переписувати


## день 13 <sup>(23.8.2022)</sup>

засів за написання мета-файлів<br />
цілу папку для цього виділив<br />
планування перепланування


## день 14 <sup>(24.8.2022)</sup>

шукав армію, може ще будівлі якісь<br />
переглянув 2239 спрайтів, трохи очманів

за якістю було усе: від мікро-збочення до топ-класу<br />
дещо навіть зберіг — на потім<br />
на зараз — доведеться ставити плейсхолдери :(


## день 15 <sup>(25.8.2022)</sup>

планування, структурування, переписування<br />
голова обертом, треба відпочити від усього цього<br />
декілька днів, може з тиждень)


## день 16 <sup>(26.8.2022)</sup>

за тиждень інтенсив, дуркувати ніколи<br />
переписав структуру коду


## день 17 <sup>(27.8.2022)</sup>

почав переписувати код за новою структурою<br />
не подобається<br />
усе у смітник, разом із папкою мета-файлів<br />
переписую знову<br />
тепер ніби подобається


## день 18 <sup>(28.8.2022)</sup>

ще трохи переписав


## день 19 <sup>(29.8.2022)</sup>

і ще трішечки... зовсім трошки.... клята спека доканає (ні)<br />
схоже, просто зникає ентузіазм, коли задачка вже розв’язана<br />
взявся за юнітів, щоб не гаяти час

паралельно хтів розписати усіх юнітів, що будуть у грі<br />
вийшло: просто повторив тих, що вже на спрайтах >_><br />
треба викинути спрайти з голови

код

мало бути ось так<br />
![true story 3.jpg](true_story_3.jpg)<br />
(не код, чисто для наочності)

але так марную дофіга часу просто щоб вказати змінну<br />
не хочу

краще буду писати ось так<br />
![true story 4.jpg](true_story_4.jpg)<br />
(шматок готового коду)

ну так, трохи головняк бо в Lua немає жорсткої типізації даних<br />
хоча там і свої плюси, я гадаю


## день 20 <sup>(30.8.2022)</sup>

шо по коду юнітів буде

поля:
- ім’я
- гравець
- команда (якщо спроможусь на мультиплеєр)
- початкові стати
- спрайти (або спрайт, бо на холяву анімація дзуськи)
- хітпоінти
- очки дій (1–2 для юнітів, будівлі — до 4-х)
- вартість найму
- черга (типу як в тактичних рпг’шках буває, ну а шо?)
- розмір (для транспортування)
- і може витривалість ще, але це не точно

дії:
- чекати (змінює чергу)
- відпочивати, щоб відновити здоров’я (але здебільшого витривалість, якщо буде)
- захищатись (баф захисту, може ще які фічі з прокачкою)
- рухатись
- атакувати
- звести будівлю (селяни та інженери)
- захопити будівлю (лише піхота)
- завантажитись (у транспорт)
- розвантажитись
- об’єднати (однотипні) загони

корочше, дофіга роботи прямо по курсу


## день 21 <sup>(31.8.2022)</sup>

на хвилиночку, минуло цілих три тижні з того дня, коли я дійсно почав щось робити<br />
щодня по кроку до мети<br />
it ain't much, but it's honest work :D

дозволив собі відпочинок)


## день 22 <sup>(1.9.2022)</sup>

якщо комусь цікаво, мої розширення під vs code:<br />
![true story 5.jpg](true_story_5.jpg)<br />
Love2D щоб швидко тестувати проект<br />
і Sort Lines — працює трохи дивно (лише через мультикурсор, чи як його) але працює

здається, десь на днях трохи пописав камеру<br />
хоча від камери там лише уявлення (та й те приблизне)

і взагалі не впевнений, чи треба?<br />
паралакс не планую, а під координат миші вже є по функції

хіба що маштабування зробити, щоб змінювалось не миттєво, а поступово<br />
а ще ж ui — отже треба


## день 23–25 <sup>(від 2.9.2022)</sup>

почався інтенсив = у мережі з’являтимуся рідше<br />
через що і робота над грою сповільниться (але не зупиниться)

далі **трохи роздумів** про наболіле)

з’ясувалося, що реалізувати камеру складніше, аніж гадалося<br />
тож спершу треба упорядкувати думки

чарунки, будівлі та юніти — усі мають (або матимуть) функцію **draw()**<br />
усі (будуть) розкидані по своїх контейнерах, які будуть присобачені до Map<br />
котра, у свою чергу, теж матиме функцію draw(), але дуже простеньку, по типу

```Lua
for _, obj in pairs( якийсь контейнер) do
    obj:draw()
end
```

найбільша проблема:<br />
(тут була «найбільша проблема», але тепер вона здається настільки очевидною,<br />
що й не варта уваги)

отже, буде дві камери: одна для мапи, інша — для решти

наступна проблема: до якої камери притулити підсвчування об’єкту, на який наведено курсор?<br />
адже такий об’єкт може бути як на одній, так і на іншій камері

найпростішим рішенням покищо здається: прикрутити на обидві<br />
і зробити десь окрему змінну, щоб відображався лише один елемент, а не усі разом

(на цьому місці була ще купа нудних та незрозумілих питань, які теж не актуальні)

а для реалізації підсвічування можна

1) прикручувати до кожного об’єкту (або відкручувати) додаткову змінну-індикатор,<br />
та переписати draw() цього об’єкта, щоб розрізняв: відмальовувати по стандарту, чи під фокусом<br />
хоча при цьому змінити відображення буде дуже складно, гадаю (та й взагалі купа мороки)

2) дописати нову функцію, яка буде окремо домальовувати фокус (що буде простіше, тож почну з цього)

переваривши написане (та повикидувавши купу непотрібу) **дійшов таких висновків**

важко, бо не з того боку почав :)<br />
зпершу треба зібрати якусь подобу класу для керування грою<br />
цей клас буде з’ясувати, чим гравець користується для гри<br />
ну і підсвітка фокусу теж від нього буде залежати

нумс, якось так я і пишу цю гру)


## день 26 <sup>(10.9.2022)</sup>

десь днів три–чотири зжерла застуда — тепер маю наздоганяти інтенсив<br />
але я нарешті створив репозиторій, хоча до кінця так і не розібрався, що і як воно там працює<br />
https://github.com/red-rabbit-games/bemyfirst


## день 27 <sup>(13.9.2022)</sup>

переписав Мапу — з рештою, там буде дофіга усього<br />
функції, які покищо нема де притулити, кидатиму в окрему теку


## день 28 <sup>(14.9.2022)</sup>

хто ж знав, що десь в інтернетах вже існує Red Rabbit Games? >__><br />
як і Grim Rabbit Games...

коротше, репозиторій відтепер буде за адресою<br />
https://github.com/darkestinkgames/bemyfirst

трохи змінив принцип створення об’єктів для мапи<br />
відтепер кожен дотичний клас сам знає, куди додавати об’єкт<br />

підписав деякі поля


## день 29 <sup>(17.9.2022)</sup>

збився з ритму, починаю губитися у власному коді) намагався прописати собі ТЗ<br />
але схоже, що це якийсь окремий недосяжний вид мистецтва<br />
краще буду прописувати детальні коментарі


## день 30 <sup>(18.9.2022)</sup>

намагався трохи поліпшити процес (і знову анотації)

можна прописувати клас повністю перед об’єктом, що доволі зручно та й на вигляд приємніше<br />
але назви полей теж треба прописувати і це морока, якщо поля будуть перейменовуватися<br />
прописати лише назву класу, а решту по ходу дійства — буде простіше<br />
але тоді на вигляд не дуже

ще й енумерація: у першому випадку можна створити на місці, у другому — лише через окремий об’єкт


## день 31 <sup>(19.9.2022)</sup>

згадав, що була проблема зі шрифтом, коли перемикаюсь у повноекранний режим<br />
здається виправив (встановив фільтр на **'linear'**), але не впевнений

трохи описав камеру, може збільшувати<br />
трохи упорядкував файли


## день 32 <sup>(20.9.2022)</sup>

ще трохи пописав камеру<br />
**колесико миші** маштабує<br />
**wasd** пересуває по декілька пікселів за натиск<br />
але робить усе це покищо не достатньо гарно<br />
доведеться ще попрацювати


## день 33 <sup>(21.9.2022)</sup>

мав доробити камеру, ніби почало усе працювати як треба<br />
але потім я подумав: а нащо мені окремий об’єкт? і так норм буде<br />
коротше, з якогось дива зсув/маштаб більше не реагують взагалі...

![true story 6.jpeg](true_story_6.jpeg)

лише з купою **print**’ів нарешті з’ясував: що десь прогавив **pushtimer**’и

схоже, недосипи даються взнаки


## день 34 <sup>(22.9.2022)</sup>

наступний затуп з камерою:
- код для зсуву по клаві запхав у *love.update(dt)* і трохи змінив
- через що *Camera:addPosition(x, y)* опинилася у постійному циклі
- через що таймер пересування ніколи не обнулявся
- і через що зламалося маштабування

хз скільки часу кумекав і обліплював код *print*’ами, доки не знайшов<br />
біль =.=


## день 35 <sup>(23.9.2022)</sup>

намагався переписати й потестити камеру, щоб працювала так, як мені треба

заплутався


## день 36 <sup>(24.9.2022)</sup>

коротше, як можна було вже здогадатися, я підзабив на інтенсив і піднасів на гру<br />
виявляється, на онлайн-уроках у сплячку хилить не гірше, аніж колись на звичайних

третя спроба зібрати камеру<br />
серія затупів цього разу: забув, як та метатабл-я працює...<br />
***rawset*** і ***rawget***, хай йому грець !! >_>

результатом страждань став новий клас **Limits**<br />
що зберігає діапазон мін/макс значень та деякі фунції для роботи з ними<br />
можна навіть додати значення у діапазон (а можна і не додавати)

загалом: здається, працює<br />
лишилося зібрати


## день 37 <sup>(25.9.2022)</sup>

переробляючи камеру зрозумів, що треба доробити клас **Limits**<br />
тепер значення кожного атрибуту можна змінювати без додаткових обмежень


## день 38 <sup>(26.9.2022)</sup>

мені не сподобалось, як воно (Limits)<br />
бракує універсальності<br />
викинув

змарновані час і сили)<br />
натомість написав простенький (ні) та дуже вузькоспеціалізований клас **CamVals**

also, сьогодні дізнався, що по назвам верхнього рядку vs code можна клікати мишею<br />
типу для швидкої навігації — зручніше за віконце **outline**

![true_story_7.jpg](true_story_7.jpg)


## день 39 <sup>(27.9.2022)</sup>

і знову все зламалося

то швидкість пересування не така<br />
то швидкість маштабування<br />
то при маштабуванні усе летить шкереберть<br />

а яким простим усе здавалося на початку :)<br />
біль


## день 40 <sup>(28.9.2022)</sup>

вже хотів було брати готову бібліотеку з камерою, та не сподобався функціонал

загалом, здається я зрозумів, де затуп, але покищо хай буде так<br />
бо нема бажання більш марнувати часу на камеру

потім дороблю


## день 41 <sup>(30.9.2022)</sup>

якщо підсумувати, на камеру змарнував 9 (робочих) днів<br />
та мало що вийшло путнього, лише безладу збільшилось<br />
буду потрохи викидати непотріб


## день 42 <sup>(1.10.2022)</sup>

витратив час та сили, та хоч трохи досвіду здобув<br />
здається, починаю краще розумітися на кодуванні<br />
особливо те, наскільки я там усе ускладнював :)

нажаль, сам прогрес просувається вкрай повільно і це пригнічує<br />
покищо збавлю трохи амбіцій аби отримати хоч якісь результати

як то кажуть, better done than perfect


## день 43 <sup>(2.10.2022)</sup>

добра новина — плейсхолдери відпадають!<br />
відтепер у грі буде ось ця братва<br />
https://itch.io/s/77079/minifolks-bundle<br />
хіба що на репозиторій заль’ю лише силуети<br />
з очевидних причин

погана новина<br />
спрайти міні-братви 32х32, а на карту — 16х16<br />
тож доведеться переписувати **Sprite()**<br />
і ще купу всього

...або не доведеться)

зпершу кинувся писати анімацію (не усвідомлюючи того, який це шмат роботи)<br />
та добре, згадав, що **anim8** нахвалювали — спробував

***Finally, Some Good Fucking Food***


## день 44 <sup>(3.10.2022)</sup>

виявляється, у **vs code** можна було встановити розмір **Tab**’ів (не подумав)<br />
два краще, ніж чотири

добре, що в **XnView** є можливість редагувати декілька файлів одразу<br />
“обілив” придбані спрайти за п’ять хвилин<br />
поки що викладу лише одну пачку

зробив невеличку бібліотеку `updatables.lua`<br />
для оновлення усього, що має `update(dt)` чи його еквівалент

трохи впорядкував файли


## день 45 <sup>(4.10.2022)</sup>

пощастило з **anim8**, може пощастить і ще з чимось<br />
пошукаю ще бібліотек, та десь окремо потестю

ще трохи впорядкував файли


## день 46 <sup>(7.10.2022)</sup>

пошукати нових бібліотек так і не спромігся<br />
але трохи проаналізував те, що мав, і потестив нову методу<br />
знову буду переписувати

доречі, робоча назва відтепер буде **MiniFolk Wars**
дуже оригінально, знаю) але краще, ніж нічого


## день 47 <sup>(8.10.2022)</sup>

маштабую кожен окремий тайл 16х16 до 32х32 і трапляється халепа)

![true_story_8.jpg](true_story_8.jpg)

найпростіший фікс
```lua
love.graphics.setDefaultFilter("nearest", "nearest")
```

але якщо я хочу зберегти можливість фильтрувати з `"linear"`?

навіть якщо підставити `love.Canvas` замість зображення, усе одно вилазить

![true_story_9.jpg](true_story_9.jpg)

здається, трабла у `love.Quad`, бо перемалював кожен тайл, як окрему канву і ось

![true_story_10.jpg](true_story_10.jpg)

пофіксив через `sprite.newScale` у `spriteset4.lua`


## день 48 <sup>(14.10.2022)</sup>

...отже, на чому я зупинився? переписати усе =.=

але зпершу напишу маленьку бібліотеку `mt.lua` <br />
щоб трохи автоматизувати роботу з метатаблицями

