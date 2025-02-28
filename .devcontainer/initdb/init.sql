-- init all tables
CREATE TABLE "user"(
    "id" SERIAL PRIMARY KEY,
    "password" VARCHAR(255) NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "username" VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE "member"(
    "user_id" INTEGER NOT NULL REFERENCES "user"("id"),
    "address" VARCHAR(255),
    "email" VARCHAR(255) NOT NULL,
    "phone_num" VARCHAR(255),
    PRIMARY KEY("user_id")
);

CREATE TABLE "vendor"(
    "user_id" INTEGER NOT NULL REFERENCES "user"("id"),
    "announcement" VARCHAR(4095),
    PRIMARY KEY("user_id")
);

CREATE TABLE "administrator"(
    "user_id" INTEGER NOT NULL REFERENCES "user"("id"),
    PRIMARY KEY("user_id")
);

CREATE TABLE "product"(
    "id" SERIAL PRIMARY KEY,
    "price" INTEGER NOT NULL,
    "description" VARCHAR(4095) NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "remain" INTEGER NOT NULL,
    "disability" BOOLEAN NOT NULL,
    "image_url" VARCHAR(255),
    "build_time" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "vendor_id" INTEGER NOT NULL REFERENCES vendor("user_id")
);

CREATE TABLE "favor"(
    "member_id" INTEGER NOT NULL REFERENCES "member"("user_id"),
    "product_id" INTEGER NOT NULL REFERENCES "product"("id"),
    "time" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    PRIMARY KEY("member_id", "product_id")
);

CREATE TABLE "cart"(
    "member_id" INTEGER NOT NULL REFERENCES "member"("user_id"),
    "product_id" INTEGER NOT NULL REFERENCES "product"("id"),
    "time" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    "count" INTEGER NOT NULL,
    PRIMARY KEY("member_id", "product_id")
);

CREATE TABLE "order"(
    "id" SERIAL PRIMARY KEY,
    "name" VARCHAR(255) NOT NULL,
    "description" VARCHAR(255) NOT NULL,
    "state" VARCHAR(255) NOT NULL,
    "address" VARCHAR(255) NOT NULL,
    "phone_num" VARCHAR(255) NOT NULL,
    "member_id" INTEGER NOT NULL REFERENCES "member"("user_id"),
    "payment_method" INTEGER NOT NULL,
    "shipment_method" INTEGER NOT NULL
);

CREATE TABLE "list"(
    "order_id" INTEGER NOT NULL REFERENCES "order"("id"),
    "product_id" INTEGER NOT NULL REFERENCES "product"("id"),
    "count" INTEGER NOT NULL,
    "time" TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    PRIMARY KEY("order_id", "product_id")
);

CREATE TABLE "tag"(
    "id" SERIAL PRIMARY KEY,
    "name" VARCHAR(255) NOT NULL,
    "type" INTEGER NOT NULL
);

CREATE TABLE "own"(
    "product_id" INTEGER NOT NULL REFERENCES "product"("id"),
    "tag_id" INTEGER NOT NULL REFERENCES "tag"("id"),
    PRIMARY KEY("product_id", "tag_id")
);

-- init all default values
INSERT INTO "user" ("password", "name", "username") VALUES 
('$2a$10$QT7PBe0i.0EftDfL.fGMb.CpN5htUTCLx/vuxvywi3y9qnVwhVqeO', 'member', 'member'),
('$2a$10$QT7PBe0i.0EftDfL.fGMb.CpN5htUTCLx/vuxvywi3y9qnVwhVqeO', 'admin', 'admin'),
('$2a$10$QT7PBe0i.0EftDfL.fGMb.CpN5htUTCLx/vuxvywi3y9qnVwhVqeO', '鬼滅之刃 代理商', 'vendor1'),
('$2a$10$QT7PBe0i.0EftDfL.fGMb.CpN5htUTCLx/vuxvywi3y9qnVwhVqeO', '獵人Hunter 代理商', 'vendor2'),
('$2a$10$QT7PBe0i.0EftDfL.fGMb.CpN5htUTCLx/vuxvywi3y9qnVwhVqeO', '出租女友 代理商', 'vendor3'),
('$2a$10$QT7PBe0i.0EftDfL.fGMb.CpN5htUTCLx/vuxvywi3y9qnVwhVqeO', '間諜家家酒 代理商', 'vendor4'),
('$2a$10$QT7PBe0i.0EftDfL.fGMb.CpN5htUTCLx/vuxvywi3y9qnVwhVqeO', '進擊的巨人 代理商', 'vendor5'),
('$2a$10$QT7PBe0i.0EftDfL.fGMb.CpN5htUTCLx/vuxvywi3y9qnVwhVqeO', '刀劍神域 代理商', 'vendor6'),
('$2a$10$QT7PBe0i.0EftDfL.fGMb.CpN5htUTCLx/vuxvywi3y9qnVwhVqeO', '葬送的芙莉蓮 代理商', 'vendor7');

INSERT INTO "member"("user_id", "email") VALUES
(1, 'member@example.com');

INSERT INTO "administrator"("user_id") VALUES
(2);

INSERT INTO "vendor"("user_id", "announcement") VALUES
(3, '⭐️以下注意事項請於購買前詳細閱讀⭐️<br/>1.本預購商品係依據您的需求向廠商訂購，恕不接受預購後要求取消訂單或退款退貨。<br/>2.本商品除瑕疵品協助換貨外，恕不接受任何理由取消訂單、退款及退貨。<br/>3.預購商品建議統一將同年同月份併結帳，不同月份的預購商品恕分開計單結帳，需等候全部商品到貨後才會一起寄出，可能會造成您更久的等待。<br/>4.不同月份的預購商品如需拆單寄出，需支付運費 NT.100。<br/>5.商品預購完成後，如遇缺斷貨、廠商法生產或無法掌控之因素等，我們必須取消您的訂單時，預購款項將全額退款。<br/>6.商品出貨配送過程中難免碰撞，在不影響商品狀態下，不列為瑕疵 + 十分在意外盒完整美者，請勿下單，恕不接受因外盒碰撞申請換貨。<br/>7.預購商品到貨月份均為廠商預估告知，實際到貨日期涉及諸多因素可能會與預估月份不同，訂購人無法以延遲到貨為由取消訂單、退款。<br/>8.如廠商在產延遲或其他因素延遲到貨，因無法逐一通知，可多利用客服留言與我們詢問。<br/>9.公仔玩具、塗裝多採手工繪製 + 批次生產組裝，製作過程中難免產生細微塗裝、造型或組裝差異，差異範圍皆為 ± 小於 2cm 風險合理範圍。<br/>10.本預購商品，圖片可能為產品模擬原型，實際收到商品以實物為主。<br/>11.首抽、盒玩類商品，屬非搶奪性驚喜盲盒，無法因個人喜好挑選款式，請慎先理解此產品販售特性，再行下單！<br/>⭐️下單代表同意以上敘述。<br/>⭐️如有任何疑問請下單前詢問。<br/>'),
(4, '⭐️以下注意事項請於購買前詳細閱讀⭐️<br/>1.本預購商品係依據您的需求向廠商訂購，恕不接受預購後要求取消訂單或退款退貨。<br/>2.本商品除瑕疵品協助換貨外，恕不接受任何理由取消訂單、退款及退貨。<br/>3.預購商品建議統一將同年同月份併結帳，不同月份的預購商品恕分開計單結帳，需等候全部商品到貨後才會一起寄出，可能會造成您更久的等待。<br/>4.不同月份的預購商品如需拆單寄出，需支付運費 NT.100。<br/>5.商品預購完成後，如遇缺斷貨、廠商法生產或無法掌控之因素等，我們必須取消您的訂單時，預購款項將全額退款。<br/>6.商品出貨配送過程中難免碰撞，在不影響商品狀態下，不列為瑕疵 + 十分在意外盒完整美者，請勿下單，恕不接受因外盒碰撞申請換貨。<br/>7.預購商品到貨月份均為廠商預估告知，實際到貨日期涉及諸多因素可能會與預估月份不同，訂購人無法以延遲到貨為由取消訂單、退款。<br/>8.如廠商在產延遲或其他因素延遲到貨，因無法逐一通知，可多利用客服留言與我們詢問。<br/>9.公仔玩具、塗裝多採手工繪製 + 批次生產組裝，製作過程中難免產生細微塗裝、造型或組裝差異，差異範圍皆為 ± 小於 2cm 風險合理範圍。<br/>10.本預購商品，圖片可能為產品模擬原型，實際收到商品以實物為主。<br/>11.首抽、盒玩類商品，屬非搶奪性驚喜盲盒，無法因個人喜好挑選款式，請慎先理解此產品販售特性，再行下單！<br/>⭐️下單代表同意以上敘述。<br/>⭐️如有任何疑問請下單前詢問。<br/>'),
(5, '每周二公休<br/>⭐️訂購or現貨注意事項⭐️<br/>1.標題 月份 是日本明年發售時間。<br/>2.免訂金商品不接受任何理由取消交易。<br/>3.對外盒要求完美者請勿下單，請至店內選購。<br/>4.不接受下標店內取貨，如有需要請您到店內填寫訂單。<br/>5.免訂金預每項商品只限購一組，如需要購買多組請詢問付訂金。<br/>6.商品因大量生產，塗裝多少有些（溢色或瑕疵），能接受者再下單。<br/>7.預購商品是從日本進口，進口商品有可能延期，能接受者再進行預購。<br/>8.預購商品如遇到日本(砍量，數量不足時)，將依訂金金額優先分配(付清.訂金.取付)能接受者在進行預購。<br/>9.預購商品如遇到日本延期，廠商延遲，海關抽檢請耐心等待，不接受退訂，能接受者在進行預購。<br/>10.因外幣商品價格是以發售時的匯率進行計算，如進貨時匯率波動過大，請配合修改訂單金額，能接受在進行預購。<br/>⭐️下單代表同意以上敘述。<br/>⭐️如有任何疑問請下單前詢問。<br/>⭐️員林卡通漫畫屋感謝您的選購⭐️<br/>'),
(6, '⭐購物須知⭐<br/>1》販售動漫商品、一番賞皆為正版。<br/>2》商品皆為為工廠大量製造，脫線、刮痕、塗裝瑕疵、溢色等情形為正常現象，能接受再下單。<br/>3》運輸關係盒況可能會受到擠壓，在意外盒者請審慎評估。<br/>4》急單請選擇宅配，超商時間會比較久!!<br/>5》賣場不提供殺價❌保留服務❌<br/>6》包裹拆箱請錄影，保障您我權益^^<br/>7》外包裝袋、配件等任何問題請先聊聊詢問。<br/>'),
(7, '歡迎光臨:《進擊的巨人》<br/>★【出貨注意】<br/>下單後正常2-3出貨，特殊情況下可能需要4-5天；物流需要5-6個工作日左右才能到您手上哦！<br/>★【購物說明】<br/>1.不同批到貨的商品尺寸及顏色，皆會有些許色差，還請各位買家見諒喔！<br/>2.不同批到貨的商品尺寸為手工量測，可能會有1-3公分的誤差，請以實物為準喔！<br/>3.請確認好規格再下單，下單後若要更改訂單內容，請自行取消再重新下單！<br/>4.不要在聊聊和訂單備註顏色款式，下單前請確認顏色款式，並下單正確！<br/>5.請確認好規格再下單,若有額外需求請在“備註”中通知,訂單建立後,不可更改!<br/>6.商品因拍攝燈光原因和電腦顯色略有不同，商品圖可以參考，請以實際商品為準！<br/>出貨時間:<br/>周一--周五:08:00~ 12:00 (周六周日 休息倉庫不出貨)<br/>'),
(8, '【🏪歡迎光臨🏪】<br/>📣📣📣歡迎光臨~ 賣場均為現貨喔📣📣📣<br/>【關於訂單顯示出貨時間長的說明】<br/>👌👌訂單添加質保服務後顯示預售或者出貨時間長請水水勿擔心~ <br/>🚚🚚倉庫正常約3個工作天左右會出貨(不含例假日)正常下標5-7天左右送達。<br/>🚚🚚訂單顯示的出貨時間無參考價值。 請水水耐心等待~~ <br/>📢📢本店暫時不接急單的哦急要,要出國,時間趕的粉粉們請務必慎拍並提前告知,不接急單,請水水們預留足夠的時間哦 <br/>🙏🙏取貨後如果有問題,請及時與我們聯繫,如收到的貨物存在漏發和破損等情況,請給我們拍照留言,千萬不要著急給我們差評,我們一定會第一時間給您滿意的答復和解決方案,謝謝水水的理解~~ <br/>【😊😊友友們請注意😊😊】<br/>1.關注賣場可以領取更多優惠,水水們看到不錯的商品可以自助下標,倉庫可以先安排出貨 <br/>2.下單後不取件者,擾亂正常秩序,壹律通過法律渠道追究責任,請親們自重! 訂單提示的完成付款時間不是取貨時間,取貨時間請以收到的簡訊為準哦,切記以簡訊為準。 <br/>3.超商取貨有尺寸限制,購買體積較大的產品,建議採用宅配方式寄送,或自行分成兩筆訂單! <br/>4.正常接單發貨,賣場是小本低利潤賣家,同業惡意競爭批評或高標準常給惡評買家請繞道喔~ 每個⭐⭐⭐⭐⭐星好評對我們來說都很重要,希望我們真誠的服務都會贏得您的認可! 最後祝你們購物愉快! <br/>'),
(9, '⭐購物須知⭐<br/>1》販售動漫商品、一番賞皆為正版。<br/>2》商品皆為為工廠大量製造，脫線、刮痕、塗裝瑕疵、溢色等情形為正常現象，能接受再下單。<br/>3》運輸關係盒況可能會受到擠壓，在意外盒者請審慎評估。<br/>4》急單請選擇4大超商，蝦皮店到店時間會比較久!!<br/>5》賣場不提供保留服務❌<br/>6》包裹拆箱請錄影，保障您我權益^^<br/>⭐️下單代表同意以上敘述。<br/>⭐️如有任何疑問請下單前詢問。<br/>希望我們真誠的服務都會贏得您的認可! 最後祝你們購物愉快! <br/>');

INSERT INTO "tag"("name", "type") VALUES
('鬼滅之刃', 0),
('獵人Hunter', 0),
('出租女友', 0),
('間諜家家酒', 0),
('進擊的巨人', 0),
('刀劍神域', 0),
('葬送的芙莉蓮', 0),
('公仔', 1),
('徽章', 1),
('資料夾', 1),
('鑰匙圈', 1),
('馬克杯', 1),
('掛畫', 1),
('滑鼠墊', 1),
('雨傘', 1),
('衣服', 1);

-- TODO : add more products later
INSERT INTO "product"("price", "description", "name", "remain", "disability", "image_url", "build_time", "vendor_id") VALUES
(590, '此公仔為一名持劍角色，背景為黑暗森林，特效呈現出冰霜般的波動感，動態感強烈，細節精美。', 'SE公仔 柱稽古篇-時透無一郎', 100, false, 'https://i.imgur.com/8erzQOS.png', '2024-12-25 00:00:00', 3),
(590, '公仔呈現一位角色搭配巨蛇環繞，角色身穿條紋衣，手握武士刀，氣勢逼人，紫色蛇特效增添神秘感。', 'SE公仔 柱稽古篇-伊黑小芭內', 50, false, 'https://i.imgur.com/tAkMLXM.png', '2024-12-25 00:01:20', 3),
(590, '這款公仔展現一名表情瘋狂的角色，手握利劍，身穿武士服，周圍綠色特效環繞，動作張力十足，氣氛緊張激烈。', 'SE公仔 柱稽古篇-不死川實彌', 50, false, 'https://i.imgur.com/jOHa5iE.png', '2024-12-25 00:03:10', 3),
(590, '該公仔一名身穿紫色和服的角色，持刀單眼蒙布，表情自信且從容，姿態輕鬆，整體風格帶有濃厚的和風氣息。', 'MAXIMATIC 宇隨天元', 40, false, 'https://i.imgur.com/LNH70ry.png', '2024-12-26 10:00:10', 3),
(590, '這款公仔展現一位身披金色鎧甲的角色，頭頂雙角，背後環繞六個印有「憎」字的法器，搭配黑紅背景，氣勢莊嚴而充滿威懾力。', '鬼之裝EX 憎珀天', 75, false, 'https://i.imgur.com/ZZo6bHV.png', '2024-12-26 10:20:10', 3),
(590, '這款公仔呈現一名擁有綠色頭髮的角色，手持鋸齒狀武器，身形瘦削，穿著破損的服飾，搭配綠色背景文字裝飾，散發詭異而邪魅的氛圍。', '鬼之裝EX 妓夫太郎', 75, false, 'https://i.imgur.com/k9AMhyX.png', '2024-12-26 10:22:10', 3),
(590, '這款公仔描繪一位擁有白色長髮與鬼角的角色，身穿鮮豔紋路的服飾，搭配紫色背景文字，展現妖魅氣質與華麗細節，充滿強烈的視覺衝擊力。', '鬼之裝EX 墮姬', 75, false, 'https://i.imgur.com/hRAt0lo.png', '2024-12-24 09:24:50', 3),
(150, '一名戴著眼鏡、面帶微笑的少年角色，神情充滿朝氣，背景以柔和的綠色環形圖案襯托。', '第一彈徽章-竈門炭治郎', 150, false, 'https://i.imgur.com/VbQ6muh.png', '2024-12-21 00:01:00', 3),
(150, '一位身著粉色帽子與服飾的少女角色，表情溫柔可愛，背景以粉紫色圖案增添柔美氣息。', '第一彈徽章-竈門彌豆子', 150, false, 'https://i.imgur.com/o2hU51l.png', '2024-12-21 00:02:00', 3),
(150, '一名金色頭髮的少年，眼神驚訝帶著些許天真，背景搭配米黃色圓環，展現純真的氛圍。', '第一彈徽章-我妻善逸', 150, false, 'https://i.imgur.com/nEGl07F.png', '2024-12-21 00:03:00', 3),
(150, '一位戴著野豬頭盔的少年，神情調皮且自信，背景以淺藍色環形設計增添活力感。', '第一彈徽章-嘴平伊之助', 150, false, 'https://i.imgur.com/OTcnetD.png', '2024-12-21 00:04:00', 3),
(150, '一名表情冷峻的男子，黑色長髮隨風飄動，背景為深藍色圓形圖案，散發沉穩氣質。', '第一彈徽章-富岡義勇', 150, false, 'https://i.imgur.com/sQXymA3.png', '2024-12-21 00:05:00', 3),
(150, '一位穿著復古帽子與服裝的男子，笑容爽朗且自信，背景為褐色環形圖案，展現熱情的性格。', '第一彈徽章-煉獄杏壽郎', 150, false, 'https://i.imgur.com/bW4waaw.png', '2024-12-21 00:06:00', 3),
(150, '一名紫色髮梢的女子，微笑中帶著些許神秘，背景為紫色圓形設計，增添優雅氣息。', '第一彈徽章-胡蝶忍', 150, false, 'https://i.imgur.com/lwske6v.png', '2024-12-21 00:07:00', 3),
(150, '一位帶著蝴蝶髮飾的少女，面容溫柔，散發恬靜的氣質，背景以柔粉紫色圖案烘托細膩美感。', '第一彈徽章-栗花落香奈乎', 150, false, 'https://i.imgur.com/EV52nZw.png', '2024-12-21 00:08:00', 3),
(150, '少年角色手持盒子，背景為柔和的綠色窗框設計，展現出樸素與溫暖的氛圍。', 'A4資料夾-竈門炭治郎', 200, false, 'https://i.imgur.com/HjSHHYr.png', '2024-12-21 01:00:00', 3),
(150, '少女角色手抱籃子，頭戴粉色帽子，背景為粉色窗框設計，整體風格柔美可愛。', 'A4資料夾-竈門彌豆子', 200, false, 'https://i.imgur.com/ODmYVC9.png', '2024-12-21 01:01:00', 3),
(150, '金髮少年手持一封信，背景搭配米黃色窗框，突顯他純真的氣質。', 'A4資料夾-我妻善逸', 200, false, 'https://i.imgur.com/6nlBUrh.png', '2024-12-21 01:02:00', 3),
(150, '戴野豬頭盔的少年，手持武器，背景為淺藍色窗框設計，散發活力與野性。', 'A4資料夾-嘴平伊之助', 200, false, 'https://i.imgur.com/Jrc0hOE.png', '2024-12-21 01:03:00', 3),
(150, '黑髮男子表情冷峻，手握武士刀，背景為深藍色窗框，呈現莊重與穩重的風格。', 'A4資料夾-富岡義勇', 200, false, 'https://i.imgur.com/PH9X096.png', '2024-12-21 01:04:00', 3),
(150, '穿著復古西裝的男子，頭戴帽子，手持文件，背景為褐色窗框，展現紳士氣質。', 'A4資料夾-煉獄杏壽郎', 200, false, 'https://i.imgur.com/a22UnaS.png', '2024-12-21 01:05:00', 3),
(150, '紫髮梢女子，手持茶杯，背景為紫色窗框，營造神秘且優雅的氣息。', 'A4資料夾-胡蝶忍', 200, false, 'https://i.imgur.com/OQK2szy.png', '2024-12-21 01:06:00', 3),
(150, '戴蝴蝶髮飾的少女，手持盤子，背景為粉紫色窗框設計，突顯恬靜與柔和的特質。', 'A4資料夾-栗花落香奈乎', 200, false, 'https://i.imgur.com/vhl9YlF.png', '2024-12-21 01:07:00', 3),
(150, '這款資料夾以淡藍色為基調，左側為精緻的花卉與文字設計，展現典雅氛圍；右側描繪紫色西裝搭配白色荷葉領的宇隨天元，神情自信，整體設計充滿華麗與細節感。', 'A4資料夾-宇隨天元', 200, false, 'https://i.imgur.com/2CVGtSM.png', '2024-12-21 01:08:00', 3),
(150, '這款資料夾以淡藍色為主色調，左側設計以花卉與優雅文字呈現，彰顯細膩風格；右側描繪身著黑色服飾的時透無一郎，搭配帽子與藍綠漸變髮色，手持甜點，神情冷靜且專注，整體氛圍清新而精緻。', 'A4資料夾-時透無一郎', 200, false, 'https://i.imgur.com/MGNPuu8.png', '2024-12-21 01:09:00', 3),
(150, '這款資料夾是以甘露寺蜜璃為主題，整體粉紅色調超可愛，左邊是花卉和文字設計，簡約又精緻；右邊的蜜璃穿著和服，笑容甜美，手上還端著精緻的甜點，超級療癒！', 'A4資料夾-甘露寺蜜璃', 200, false, 'https://i.imgur.com/aua29LR.png', '2024-12-21 01:10:00', 3),
(135, '這款鑰匙圈以Q版角色設計為特色，展現一名手持武士刀、表情開朗的少年，搭配綠色格紋背景，整體造型充滿可愛與活力感。', 'Q版鑰匙圈-竈門炭治郎', 80, false, 'https://i.imgur.com/b6XgsTQ.png', '2024-12-21 02:00:00', 3),
(135, '這款鑰匙圈以Q版設計呈現金髮少年，他雙眼緊閉、持刀跪地，展現冷靜瞬間，搭配黃色格紋背景，整體風格溫暖又充滿張力。', 'Q版鑰匙圈-我妻善逸', 80, false, 'https://i.imgur.com/qJdq9JZ.png', '2024-12-21 02:01:00', 3),
(135, '這款鑰匙圈以Q版風格呈現戴著野豬頭盔的角色，雙手持刀擺出攻擊姿勢，背景以藍色格紋搭配，增添活潑且充滿力量的氛圍。', 'Q版鑰匙圈-嘴平伊之助', 80, false, 'https://i.imgur.com/h4cVCsH.png', '2024-12-21 02:02:00', 3),
(135, '這款鑰匙圈以Q版風格呈現黑髮男子，表情冷峻，身披綠色花紋披風，手持武士刀，背景為淺藍色格紋，展現沉穩與強大的氣場。', 'Q版鑰匙圈-富岡義勇', 80, false, 'https://i.imgur.com/uN1GLEs.png', '2024-12-21 02:03:00', 3);

INSERT INTO "product"("price", "description", "name", "remain", "disability", "image_url", "build_time", "vendor_id") VALUES
(1100, '這款公仔描繪一名黑髮少年身穿白色背心和綠色短褲，擺出戰鬥姿勢，雙手凝聚橙色能量球，神情充滿自信，展現動感與力量。', '小傑·富力士', 10, false, 'https://i.imgur.com/QcYsuxR.png', '2024-12-27 00:00:00', 4),
(580, '這款公仔呈現一位黑髮女性角色，身穿綠色服裝搭配金色裝飾，擺出優雅而充滿力量的姿勢，手中握有粉色能量效果，動態感十足。', '伊耳謎·揍敵客', 60, false, 'https://i.imgur.com/uXVZTFZ.png', '2024-12-27 00:01:00', 4),
(580, '這款公仔描繪一名紅髮角色，身著黑紅相間的服裝，胸前點綴紅色符號，擺出輕鬆自信的姿態，手中展示粉色能量效果，充滿戲劇性與個性化特徵。', '西索·莫羅', 60, false, 'https://i.imgur.com/jWwH18h.png', '2024-12-27 00:02:00', 4),
(580, '這款公仔描繪一名紫色頭髮的少女角色，蹲坐姿態自然，神情帶有一絲冷峻與思索，服裝簡約而富有動感，背景燈光營造出靜謐的氛圍。', '瑪奇·柯瑪琪娜', 60, false, 'https://i.imgur.com/ynjrL4r.png', '2024-12-27 00:03:00', 4),
(580, '這款公仔描繪一名金色短髮的角色，身穿紫色系服裝，悠閒地坐在樹枝上，神情輕鬆自然，背景燈光柔和，營造出靜謐且放鬆的氛圍。', '俠客', 50, false, 'https://i.imgur.com/drtI6xN.png', '2024-12-27 00:04:00', 4),
(280, '黑色尖髮的少年，身穿綠色服裝，神情活潑，右手揮舞展現元氣，背景搭配綠色圓形設計。', '小傑·富力士', 30, false, 'https://i.imgur.com/Qdr2IBF.png', '2024-12-27 01:00:00', 4),
(280, '白髮少年踩著滑板，身穿藍白相間服飾，神情冷靜自信，背景以藍色圓形烘托動感。', '奇犽·揍敵客', 30, false, 'https://i.imgur.com/dRqHHaH.png', '2024-12-27 01:01:00', 4),
(280, '金髮少年手持木棍，身穿藍色長袍，表情認真專注，背景使用淺橙色圓形設計。', '酷拉皮卡', 30, false, 'https://i.imgur.com/zJG33g5.png', '2024-12-27 01:02:00',4),
(280, '黑髮少年身穿西裝，動作奔跑帶有緊張感，神情驚訝，背景搭配淺藍色圓形，突顯動態氛圍。', '雷歐力·帕拉丁奈特', 30, false, 'https://i.imgur.com/TbyUHJE.png', '2024-12-27 01:03:00', 4),
(250, '黑色尖髮少年背對觀眾，穿著綠色套裝，肩背棕色背包，手持魚竿回眸一笑，背景為鮮明的綠色，突顯角色的冒險氣質。', '小傑·富力士', 70, false, 'https://i.imgur.com/JZ71KDH.png', '2024-12-27 01:30:00', 4),
(250, '白髮少年側身回頭，身穿白色短袖與深色短褲，手中持著迴力刀，神情冷酷，背景為紫色，展現沉穩且神秘的氣息。', '奇犽·揍敵客', 70, false, 'https://i.imgur.com/YlrwvZ1.png', '2024-12-27 01:31:00', 4),
(250, '黑髮男子戴著眼鏡，穿著深藍色西裝，背對觀眾微微側頭，神情冷峻，背景為藍色，展現穩重與成熟的氣質。', '雷歐力·帕拉丁奈特', 70, false, 'https://i.imgur.com/eohSRSz.png', '2024-12-27 01:32:00', 4),
(250, '金髮少年面向觀眾，身穿白色襯衫和藍色長袍，手上戴著銀色鍊具，神情專注，背景為金黃色，突顯他的堅毅與決心。', '酷拉皮卡', 70, false, 'https://i.imgur.com/O8I2nGI.png', '2024-12-27 01:33:00', 4),
(250, '紅髮男子背對觀眾，身穿白色服裝，胸前印有黑桃與紅心符號，手中持一張撲克牌，露出自信笑容，背景為粉紅色，突顯其神秘與狡黠的特質。', '西索·莫羅', 70, false, 'https://i.imgur.com/7HWNzRH.png', '2024-12-27 01:34:00', 4),
(250, '黑髮男子側身面向觀眾，身穿綠色服裝，腰間綴有金色裝飾，手持雙針，神情冷酷，背景為深綠色，展現其凌厲與決斷的氣場。', '伊耳謎·揍敵客', 70, false, 'https://i.imgur.com/Szczf4W.png', '2024-12-27 01:35:00', 4),
(250, '黑髮男子側身回頭，身穿紫色大衣，背後印有金色十字架圖案，領口鑲有白色毛邊，手中持撲克牌，背景為紫色，展現神秘與威嚴的氣息。', '庫洛洛·魯西魯', 70, false, 'https://i.imgur.com/lNFOvme.png', '2024-12-27 01:36:00', 4),
(250, '黑髮男子背對觀眾，身穿黑色大衣，背後印有骷髏與交叉骨頭圖案，手持武器微微回頭，背景為深藍色，展現冷酷與危險的氛圍。', '飛坦·博通', 70, false, 'https://i.imgur.com/M6E8b8P.png', '2024-12-27 01:37:00', 4),
(480, '以簡潔的「X」標誌為主，紅黑色對比突出，底部附有「Hunter Association」字樣，展現獵人協會的象徵。', '獵人協會', 25, false, 'https://i.imgur.com/Z63V6Yw.png', '2024-12-27 01:40:00', 4),
(480, '藍紫色背景搭配黑色蜘蛛圖案，象徵神秘與危險，簡約卻充滿張力的設計。', '暗影旅團', 25, false, 'https://i.imgur.com/7BbDYZu.png', '2024-12-27 01:41:00', 4),
(480, '黃色背景襯托黑髮少年角色，他身著經典服裝，神情自信，兩側的裝飾圖案增添活力感。', '小傑·富力士', 25, false, 'https://i.imgur.com/7TkMA3X.png', '2024-12-27 01:42:00', 4),
(480, '黑紅菱形背景，描繪戴眼鏡的黑髮男子，他神態從容，風格復古而優雅。', '雷歐力·帕拉丁奈特', 25, false, 'https://i.imgur.com/J9KISLi.png', '2024-12-27 01:43:00', 4);

INSERT INTO "product"("price", "description", "name", "remain", "disability", "image_url", "build_time", "vendor_id") VALUES
(5500, '這款水原千鶴公仔以粉紅色泳裝設計，展現清純與性感兼具的氣質。流線型的設計與精緻雕工，重現角色的迷人姿態，是收藏家的必備之選。', '水原千鶴-競泳泳裝Ver.', 10, false, 'https://i.imgur.com/0QizMCb.jpeg', '2024-12-28 00:00:00', 5),
(6150, '水原千鶴的居家情境造型，身穿純白蕾絲睡衣，細節精緻到每一根褶皺，營造溫馨又浪漫的氣氛，是角色粉絲必不可少的收藏珍品。', '水原千鶴-透視睡衣天使白Ver.', 10, false, 'https://i.imgur.com/cSrXpv6.jpeg', '2024-12-28 00:01:00', 5),
(680, '這幅掛畫展現了水原千鶴優雅回眸的瞬間，穿著輕盈的夏日洋裝，背景描繪生動的街景，充滿浪漫氣息，為你的房間增添唯美與故事感。', '直向掛畫 水原千鶴', 50, false, 'https://i.imgur.com/cazvCtx.jpeg', '2024-12-28 00:05:00', 5),
(1320, '七海麻美的可愛女僕造型掛畫，以俏皮黑色比基尼與貓耳裝飾吸引目光，黃色背景搭配蕾絲細節，增添了甜美又不失性感的氛圍。', '掛畫 七海麻美-泳裝女僕', 25, false, 'https://i.imgur.com/LV7An3q.jpeg', '2024-12-28 00:10:00', 5),
(1320, '更科瑠夏的掛畫以清新藍白主題展現角色甜美的一面，女僕造型搭配可愛的甜點，活潑又俏皮，給人一種青春洋溢的感覺，是房間佈置的亮點選擇。', '掛畫 更科瑠夏-泳裝女僕', 25, false, 'https://i.imgur.com/kU3Jpdg.jpeg', '2024-12-28 00:15:00', 5),
(1320, '櫻澤墨的女僕造型掛畫，粉紅主題襯托她害羞內斂的性格，甜美可愛的服飾細節與溫暖的色調相結合，散發迷人魅力，是粉絲必備的裝飾品。', '掛畫 櫻澤墨-泳裝女僕', 25, false, 'https://i.imgur.com/n6BuVxz.jpeg', '2024-12-28 00:20:00', 5),
(160, '這款水原千鶴鑰匙圈以可愛的角色插圖為設計亮點，輕巧便攜，粉色調設計展現柔美氣質，是隨身攜帶角色魅力的最佳選擇，適合作為日常配件或小禮物。', '水原千鶴', 100, false, 'https://i.imgur.com/LMUEw76.jpeg', '2024-12-28 01:10:00', 5),
(160, '櫻澤墨的鑰匙圈設計以Instagram風格框架，搭配她羞澀可愛的形象，簡單卻充滿個性，適合喜愛低調又精緻設計的粉絲，是實用與收藏兼具的好物。', '櫻澤墨', 100, false, 'https://i.imgur.com/N6uZrvI.jpeg', '2024-12-28 01:20:00', 5),
(160, '滑鼠墊以水原千鶴的慵懶居家造型為主題，清晰的畫質與舒適材質讓操作手感極佳，深邃的星空背景更增添神秘氛圍，是電腦桌面的完美搭配。', '水原千鶴', 120, false, 'https://i.imgur.com/qPRVWzf.jpeg', '2024-12-28 01:30:00', 5),
(160, '這款滑鼠墊包含多位角色合影，色彩鮮艷且設計充滿活力，背景配上繽紛的彩帶，展現角色間的默契與互動，是動漫迷日常使用與收藏的不二之選。', '出租女友', 120, false, 'https://i.imgur.com/aGxfVSA.jpeg', '2024-12-28 01:40:00', 5);

INSERT INTO "product"("price", "description", "name", "remain", "disability", "image_url", "build_time", "vendor_id") VALUES
(590, '這款模型呈現角色與巨型白色狗狗並肩奔跑的動感瞬間，角色驚訝的表情與狗狗毛茸茸的細節相得益彰，彷彿即將開啟一場刺激冒險。生動的動態設計與逼真的姿態細節，讓人仿佛親臨故事場景，是收藏的不二之選。', 'mission extend 安妮亞+彭德', 60, false, 'https://i.imgur.com/nvQHrfl.jpeg', '2024-12-27 04:00:00', 6),
(6850, '這款模型完美呈現家庭的溫馨互動，角色穿著可愛外套開心奔跑，父親一手提著購物袋展現沉穩紳士氣質。逼真的場景還原與細膩的表情設計，將角色間的情感展露無遺。適合喜愛日常溫馨氛圍的收藏迷', '安妮亞&洛伊德', 5, false, 'https://i.imgur.com/DUdCuHo.jpeg', '2024-12-27 04:05:00', 6),
(180, '滑鼠墊以聖誕節為主題，角色一家身穿冬裝，在節日市集中留下溫馨的回憶。背景細節還原出熱鬧的節日氛圍，巨型狗狗也融入其中，畫面生動而有趣。濃濃的冬日暖意，是喜歡劇情故事的粉絲家中必備的裝飾品。', '間諜家家酒', 70, false, 'https://i.imgur.com/ZAQba0t.jpeg', '2024-12-27 04:10:00', 6),
(360, '這款馬克杯以角色與狗狗為設計主題，呈現俏皮又治癒的插圖。粉白主色調清新淡雅，適合日常使用或收藏，帶來滿滿的童趣與溫暖氛圍。杯子細節做工精緻，為你每一天的飲品增添幸福感受，是粉絲的最佳選擇。', '嘟嘟馬克杯(350ML)安妮亞&彭德', 70, false, 'https://i.imgur.com/eRvuOSn.jpeg', '2024-12-27 04:20:00', 6),
(590, '這款模型展現了角色沉穩紳士的一面，柔和綠色毛衣與修身長褲的搭配，營造出低調又精緻的氣質。自然的站姿與自信的表情，充分展現角色魅力，背景場景溫暖舒適，適合欣賞角色日常溫馨風格的粉絲收藏。', '洛伊德-涼感服飾', 80, false, 'https://i.imgur.com/fVkO65I.jpeg', '2024-12-27 04:30:00', 6),
(280, '鑰匙圈以角色的企鵝玩偶為靈感，俏皮可愛的藍白配色搭配簡單線條設計，讓小物也充滿趣味感。輕便易攜，無論是掛在背包還是鑰匙上，都能成為吸睛的亮點。粉絲們攜帶這份可愛，隨時展現自己的喜好。', '大金屬入色鑰匙圈-企鵝', 135, false, 'https://i.imgur.com/cSZuBMC.jpeg', '2024-12-27 04:40:00', 6),
(280, '靈感來自角色的花生主題，這款鑰匙圈以鮮黃配色與俏皮的花生人形象吸引目光。輕巧實用，可輕鬆搭配各類包包或鑰匙，展現個性同時增添趣味。獨特設計使其成為粉絲們的日常亮點，適合作為小禮物或收藏。', '大金屬入色鑰匙圈-花生', 135, false, 'https://i.imgur.com/uTotETq.jpeg', '2024-12-27 04:50:00', 6),
(399, '這款掛畫以角色經典姿態為主題，背景搭配藍天與場景細節，展現角色活潑可愛的神情。畫布設計色彩鮮明、質感細膩，充滿動感與生氣。是粉絲裝飾房間、辦公桌的理想選擇，讓生活空間也能擁有故事氣息。', '掛畫-安妮亞', 45, false, 'https://i.imgur.com/wXuwrCH.png', '2024-12-26 03:22:00', 6),
(590, '這款模型捕捉了角色天真爛漫的一刻，穿著鮮紅色連身裙搭配俏皮的貓耳髮飾，展現純粹的快樂與童真。動作張開雙臂，宛如跳著開心的舞步，笑容感染力十足，背景細節營造了溫暖的居家氛圍，是療癒系粉絲的最佳選擇！', '安妮亞-第一季ED服裝Ver.', 50, false, 'https://i.imgur.com/haClTQo.jpeg', '2024-12-26 04:34:00', 6),
(590, '這款模型以溫暖的鄉村田園風為主題，角色穿著柔和花紋的長裙，搭配明亮的黃色背心，整體配色充滿春日氣息。靴子與俏皮的高髮髻為整體增添細節，彷彿置身於鄉間小鎮，適合喜愛柔美風格的收藏者。', '安妮亞-時尚裝扮Vol3.5', 50, false, 'https://i.imgur.com/DWJ5oUX.jpeg', '2024-12-26 04:36:00', 6),
(590, '這款模型展現了角色的學院復古氣質，黑色連身裙與金色邊飾的搭配高貴又優雅，搭配圓頂帽與書包，細節十分考究。角色的自信笑容與行進姿勢增添動感，背景校園場景更襯托其故事性，是復古與學院風愛好者必備之選。', '安妮亞-ESPRESTO School style', 50, false, 'https://i.imgur.com/tyrKn3A.jpeg', '2024-12-26 04:38:00', 6),
(590, '這款模型以酷炫的秘密特工為主題，黑色緊身皮衣、墨鏡和武器配件，展現出角色神秘又強大的氣場。粉紅髮色與貓耳頭飾增加了俏皮感，整體造型充滿動感與張力，仿佛即將展開一場刺激的冒險，非常適合追求個性化收藏的粉絲！', '安妮亞-間諜服', 50, false, 'https://i.imgur.com/INezQJg.jpeg', '2024-12-26 04:40:00', 6),
(590, '以學院氣息濃厚的裝扮為主題，這款模型展現了角色優雅又充滿活力的一面。角色戴著草帽，身穿深綠色外套與復古領帶，搭配書本道具，彷彿剛從圖書館走出來。細節豐富，設計精緻，是書迷和學院風愛好者不可錯過的珍品。', '安妮亞-時髦版Vol2.5', 50, false, 'https://i.imgur.com/7EeBl5u.jpeg', '2024-12-26 04:42:00', 6),
(590, '這款模型以濃厚的英倫復古風為設計靈感，角色戴著俏皮的貝雷帽，身穿格紋大衣與短靴，散發濃濃的秋冬氛圍。橘紅色頭髮與休閒風搭配相得益彰，背景細節襯托出溫暖且自然的生活場景，是一款兼具質感與故事性的作品。', '安妮亞-時髦服裝穿搭Vol1.5', 50, false, 'https://i.imgur.com/Ixnlf4J.jpeg', '2024-12-26 04:44:00', 6),
(590, '這款模型呈現了角色的夏日休閒風情，穿著清新俏皮的水手服，搭配綠白條紋游泳圈，宛如站在陽光下的沙灘上。粉紅色頭髮增添了活潑感，細膩的做工讓每個細節栩栩如生，是熱愛夏日氛圍的粉絲必備收藏品。', '安妮亞-暑假', 50, false, 'https://i.imgur.com/Zu6Tirm.jpeg', '2024-12-26 04:46:00', 6);

INSERT INTO "product"("price", "description", "name", "remain", "disability", "image_url", "build_time", "vendor_id") VALUES
(650, '回過神才發現，思考進擊的巨人雨傘的存在意義，已讓我廢寢忘食。所謂進擊的巨人雨傘，關鍵是進擊的巨人雨傘需要如何解讀。', '直傘-艾連&里維', 35, false, 'https://i.imgur.com/rIgroJp.jpeg', '2024-12-29 00:00:00', 7),
(360, '把里維馬克杯輕鬆帶過，顯然並不適合。老舊的想法已經過時了。里維馬克杯勢必能夠左右未來。探討里維馬克杯時，如果發現非常複雜，那麼想必不簡單。', '嘟嘟馬克杯(350ml)-里維', 65, false, 'https://i.imgur.com/cgGqW58.jpeg', '2024-12-29 00:01:00', 7),
(100, '深入的探討里維資料夾，是釐清一切的關鍵。一般來說，問題的關鍵看似不明確，但想必在諸位心中已有了明確的答案。帶著這些問題，我們一起來審視里維資料夾。', '炫光資料夾-里維', 110, false, 'https://i.imgur.com/PdMDSLb.jpeg', '2024-12-29 00:02:00', 7),
(580, '我們要從本質思考，從根本解決問題。儘管如此，別人往往卻不這麼想。巴金曾經認為，奮鬥就是生活，人生惟有前進。這段話雖短，卻足以改變人類的歷史。這必定是個前衛大膽的想法。透過逆向歸納，得以用最佳的策略去分析里維馬克杯。', '馬克杯-里維', 40, false, 'https://i.imgur.com/k0Cg4Ru.jpeg', '2024-12-29 00:03:00', 7),
(580, '艾連馬克杯因何而發生？馬爾頓曾提出，堅強的信心，能使平凡的人做出驚人的事業。這段話讓我所有的疑惑頓時豁然開朗。薩克雷曾經提到過，在現在的社會條件下，完全不勢利是不可能的。我希望諸位也能好好地體會這句話。', '馬克杯-艾連', 40, false, 'https://i.imgur.com/sAVXEcr.jpeg', '2024-12-29 00:04:00', 7),
(220, '曹禺曾經認為，一個真正的人，應該為人民用儘自己的才智，專長和精力，再離開人間。不然，他總會感受到遺憾，浪費了有限的生命。這讓我對於看待這個問題的方法有了巨大的改變。若能夠洞悉里維鑰匙圈各種層面的含義，勢必能讓思維再提高一個層級。', '鑰匙圈-里維', 90, false, 'https://i.imgur.com/DwphLFc.jpeg', '2024-12-29 00:05:00', 7),
(220, '塞萬提斯講過一段耐人尋思的話，有時一扇門雖然關上了，其餘的門卻是敞開的。這句話把我們帶到了一個新的維度去思考這個問題。這是不可避免的。對於艾連鑰匙圈，我們不能不去想，卻也不能走火入魔。', '鑰匙圈-艾連', 90, false, 'https://i.imgur.com/upGsRpu.jpeg', '2024-12-29 00:06:00', 7),
(320, '當你搞懂後就會明白了。一般來講，我們都必須務必慎重的考慮考慮。洛克講過，學到很多東西的訣竅，就是一下子不要學很多。這啟發了我。白哲特曾經提過，堅強的信念能贏得強者的心，並使他們變得更堅強。這段話讓我所有的疑惑頓時豁然開朗。對我個人而言，艾連·葉卡資料夾不僅僅是一個重大的事件，還可能會改變我的人生。', '艾連·葉卡', 65, false, 'https://i.imgur.com/3fJMuBk.jpeg', '2024-12-29 00:07:00', 7),
(320, '我們一般認為，抓住了問題的關鍵，其他一切則會迎刃而解。米卡莎·阿卡曼資料夾勢必能夠左右未來。米卡莎·阿卡曼資料夾的出現，重寫了人生的意義。', '米卡莎·阿卡曼', 65, false, 'https://i.imgur.com/YwgU0rY.jpeg', '2024-12-29 00:08:00', 7),
(320, '若沒有阿爾敏·亞魯雷特資料夾的存在，那麼後果可想而知。如果仔細思考阿爾敏·亞魯雷特資料夾，會發現其中蘊含的深遠意義。', '阿爾敏·亞魯雷特', 65, false, 'https://i.imgur.com/XLNX4cp.jpeg', '2024-12-29 00:09:00', 7),
(320, '席慕蓉深信，金錢是一種有用的東西，但是，只有在你覺得知足的時候，它才會帶給你快樂，否則的話，它除了給你煩惱和妒忌之外，毫無任何積極的意義。但願諸位理解後能從中有所成長。儘管如此，我們仍然需要對里維·阿卡曼 資料夾保持懷疑的態度。', '里維·阿卡曼', 65, false, 'https://i.imgur.com/cHlnk42.jpeg', '2024-12-29 00:10:00', 7),
(320, '領悟其中的道理也不是那麼的困難。我們普遍認為，若能理解透徹核心原理，對其就有了一定的了解程度。若能夠洞悉漢吉·佐耶 資料夾各種層面的含義，勢必能讓思維再提高一個層級。', '漢吉·佐耶', 65, false, 'https://i.imgur.com/I97IBUS.jpeg', '2024-12-29 00:11:00', 7),
(320, '經過上述討論，我們不得不相信，奧維德在不經意間這樣說過，愛容易輕信。這讓我對於看待這個問題的方法有了巨大的改變。每個人的一生中，幾乎可說碰到約翰·基爾休坦 資料夾這件事，是必然會發生的。', '約翰·基爾休坦', 65, false, 'https://i.imgur.com/jLP5zyR.jpeg', '2024-12-29 00:12:00', 7),
(320, '對於莎夏·布勞斯 資料夾，我們不能不去想，卻也不能走火入魔。既然，儘管莎夏·布勞斯 資料夾看似不顯眼，卻佔據了我的腦海。', '莎夏·布勞斯', 65, false, 'https://i.imgur.com/UbjhFak.jpeg', '2024-12-29 00:14:00', 7),
(320, '既然，所謂萊納·布朗 資料夾，關鍵是萊納·布朗 資料夾需要如何解讀。若能夠洞悉萊納·布朗 資料夾各種層面的含義，勢必能讓思維再提高一個層級。', '萊納·布朗', 65, false, 'https://i.imgur.com/q1Qm8Gu.jpeg', '2024-12-29 00:15:00', 7);

INSERT INTO "product"("price", "description", "name", "remain", "disability", "image_url", "build_time", "vendor_id") VALUES
(12750, '精緻還原亞絲娜的經典形象，黑色兔女郎造型搭配細膩網襪與優雅曲線，展現迷人魅力，極具收藏價值。', '亞絲娜 兔女郎Ver.', 5, false, 'https://i.imgur.com/0Uxo2kg.png', '2024-12-30 02:00:00', 8),
(650, '詩乃珍珠白兔女郎造型，以高質感呈現服裝與細節，搭配動態姿勢與個性魅力，為收藏粉絲的絕佳選擇。', '詩乃 兔女郎 珍珠白Ver.', 30, false, 'https://i.imgur.com/7nR0BSU.jpeg', '2024-12-30 02:10:00', 8),
(4680, '黑色襯衫展現亞絲娜的溫柔氣質與自然姿態，手持紅色杯子的休閒造型讓人倍感親切，適合收藏。', '亞絲娜 桐人襯衫Ver.', 20, false, 'https://i.imgur.com/JjSI81Y.jpeg', '2024-12-30 02:20:00', 8),
(4680, '白襯衫造型展現亞絲娜的清新與柔美，搭配甜美笑容與放鬆姿勢，完美體現角色日常風格。', '亞絲娜 襯衫Ver.', 20, false, 'https://i.imgur.com/RmbDg4J.jpeg', '2024-12-30 02:30:00', 8),
(180, '高質感印刷還原亞絲娜旅行主題插圖，溫泉背景與角色形象結合，實用與收藏兼具的完美選擇。', '亞絲娜 資料夾旅行Ver.', 80, false, 'https://i.imgur.com/gtt8Nn9.jpeg', '2024-12-30 02:40:00', 8),
(180, '桐人旅行主題資料夾，藍色海景襯托角色的活力形象，精緻設計兼具實用性與收藏價值。', '桐人 資料夾旅行Ver.', 80, false, 'https://i.imgur.com/pOSqwGR.jpeg', '2024-12-30 02:50:00', 8),
(600, '黑色T恤印有桐人招式「星光連流擊」主題設計，搭配日文字體與炫酷風格，展現粉絲的時尚魅力。', 'T-shirt 星光連流擊', 40, false, 'https://i.imgur.com/kDfFAW1.jpeg', '2024-12-30 03:00:00', 8),
(200, '內含兩款設計，展示桐人經典姿態與招式「星光連流擊」，採高光亮面製作，實用與收藏價值兼具。', '桐人 語錄炫光徽章組(2入)', 75, false, 'https://i.imgur.com/XFxSLOe.jpeg', '2024-12-30 03:10:00', 8),
(600, '黑色T恤以亞絲娜形象為主題，正面圖案精美，背面簡約風格，材質舒適，展現動漫粉絲的個性魅力。', 'T-shirt 亞絲娜', 40, false, 'https://i.imgur.com/8DulvDx.jpeg', '2024-12-30 03:20:00', 8),
(500, '橫向設計掛畫展現刀劍神域角色的細膩插圖，柔和色調與細緻印刷增添居家氛圍，完美點綴空間。', '掛畫 橫向 A款', 60, false, 'https://i.imgur.com/5RrxPSG.jpeg', '2024-12-30 03:30:00', 8),
(180, '精美插圖設計的滑鼠墊，提供舒適的使用體驗，角色魅力與實用功能兼具，是粉絲的必備配件。', '滑鼠墊-D款', 90, false, 'https://i.imgur.com/CVEHFy8.jpeg', '2024-12-30 03:40:00', 8),
(180, 'Q版角色滑鼠墊設計可愛，採用高品質材質製作，耐用實用，為你的工作空間增添更多動漫氛圍。', '滑鼠墊-F款(Q版)', 90, false, 'https://i.imgur.com/T1ySQ2H.jpeg', '2024-12-30 03:50:00', 8),
(300, '高畫質呈現亞絲娜與Argo的活潑互動，柔和色彩與細膩插圖完美結合，是居家裝飾的最佳選擇。', '掛畫-F款(亞+愛)', 45, false, 'https://i.imgur.com/ODejadM.jpeg', '2024-12-30 04:00:00', 8),
(320, '以騎士細劍為主題的鑰匙圈，還原武器細節，金屬材質堅固耐用，是粉絲隨身攜帶的最佳配件。', '騎士細劍鑰匙圈', 50, false, 'https://i.imgur.com/PRKXfgT.jpeg', '2024-12-30 04:10:00', 8),
(500, '半立體設計的金屬鑰匙圈，造型別緻細膩，兼具時尚與實用功能，展現刀劍神域的標誌性元素。', '半立體金屬鑰匙圈', 35, false, 'https://i.imgur.com/yErcIrZ.jpeg', '2024-12-30 04:20:00', 8),
(790, '刀劍神域後篇主題馬克杯，杯身圖案精美，容量適中，為日常使用與粉絲收藏的絕佳選擇。', '後篇 馬克杯', 35, false, 'https://i.imgur.com/CahTwTX.png', '2024-12-30 04:30:00', 8);

INSERT INTO "product"("price", "description", "name", "remain", "disability", "image_url", "build_time", "vendor_id") VALUES
(590, '這款「葬送的芙莉蓮」費倫BAP半身胸像公仔，呈現紫色長髮的費倫，臉上帶著淡淡的微笑，手托下巴，展現她沉靜且溫柔的一面，細節精緻，完全抓住角色的神韻！', '半身胸像公仔 費倫', 45, false, 'https://i.imgur.com/z3D9lDR.png', '2024-12-30 04:40:00', 9),
(590, '這款「葬送的芙莉蓮」Luminasta 花園Ver. 公仔，展現芙莉蓮溫柔的一面，她手捧藍色小花，頭戴花環，身著白金邊服飾，背景為清新自然的花園場景，完美還原角色的寧靜與優雅氛圍！', '芙莉蓮-花園Ver.', 30, false, 'https://i.imgur.com/E0Qcf7P.png', '2024-12-30 04:50:00', 9),
(590, '這款「葬送的芙莉蓮」Luminasta 花園Ver. 公仔，展現芙莉蓮溫柔的一面，她手捧藍色小花，頭戴花環，身著白金邊服飾，背景為清新自然的花園場景，完美還原角色的寧靜與優雅氛圍！', '費倫-花園Ver.', 30, false, 'https://i.imgur.com/PAmJglV.png', '2024-12-30 05:00:00', 9),
(550, '這款「葬送的芙莉蓮」TAITO Desktop Cute 家居服版本公仔，展現芙莉蓮慵懶且專注閱讀的一面。她穿著溫暖的針織外套與家居裙，盤腿坐在書堆中，手捧一本書，背景模擬書房的柔和燈光，營造出靜謐而溫馨的氣氛，非常適合作為書桌擺件！', '芙莉蓮-家居服Ver.', 15, false, 'https://i.imgur.com/RAuxMOe.png', '2024-12-30 05:10:00', 9),
(590, '這款「葬送的芙莉蓮」SE Luminasta 費倫一般攻擊魔法版本公仔，展現費倫的戰鬥姿態。她身穿白色長裙，手握法杖，裙擺隨風飄動，腳下的藍色魔法特效動感十足，完美捕捉角色施展魔法的瞬間，兼具優雅與力量感！', '費倫-一般攻擊魔法Ver.', 40, false, 'https://i.imgur.com/FXD3MAM.png', '2024-12-30 05:20:00', 9),
(590, '這款「葬送的芙莉蓮」BAP半身胸像公仔以芙莉蓮為主題，展現她溫柔且略帶思考的神情。她雙手托臉，紫色長髮紮成雙馬尾，身穿白金色裝飾的服飾，整體設計細膩優雅，完美捕捉角色的靜謐氣質，非常適合喜愛芙莉蓮的粉絲收藏！', '半身胸像公仔 芙莉蓮', 45, false, 'https://i.imgur.com/eVcG4LQ.png', '2024-12-30 05:30:00', 9),
(590, '這款「葬送的芙莉蓮」SE坐姿PM公仔以芙莉蓮為主題，展現她盤腿而坐的安靜姿態，雙馬尾的捲髮造型增添可愛感。她身穿經典白金色邊的服飾，神情平和，背景設計為溫馨的室內環境，呈現出恬靜舒適的氛圍，非常適合作為收藏或擺飾品。', '坐姿公仔 捲髮芙莉蓮', 10, false, 'https://i.imgur.com/kno1ThZ.png', '2024-12-30 05:40:00', 9),
(590, '這款「葬送的芙莉蓮」BAP Glasscape 費倫公仔，以費倫坐姿形象為主題，展現她手持法杖的靜謐姿態。背景是一個華麗的圓形透明屏飾，上面描繪了其他角色的插畫與細緻花紋，增添了濃厚的故事感與收藏價值，設計優雅且富有藝術氣息，非常適合粉絲珍藏！', 'Glasscape 費倫', 55, false, 'https://i.imgur.com/sYrm1Wi.png', '2024-12-30 05:50:00', 9),
(590, '這款「葬送的芙莉蓮」BAP Glasscape 芙莉蓮公仔，展現芙莉蓮優雅的坐姿形象，手持紅寶石法杖，散發沉穩與智慧的氣質。背景是一個透明圓形屏飾，描繪了精美的花紋與其他角色的插畫，色調以藍色為主，充滿夢幻氛圍，整體設計細膩而具有故事感，是一款極具收藏價值的公仔！', 'Glasscape 芙莉蓮', 55, false, 'https://i.imgur.com/VREMjqX.png', '2024-12-30 06:00:00', 9),
(590, '這款「葬送的芙莉蓮」SE公仔 Yumemirize 從前時光 費倫版本，以費倫的靜謐姿態為主題。她坐在草地上，身穿黑色斗篷與白色洋裝，紫色短髮上別著蝴蝶髮飾，伸手輕觸飛舞的蝴蝶，背景以夢幻的夜晚場景點綴，充滿詩意與回憶感，非常適合喜愛費倫的粉絲收藏！', '從前時光 費倫', 25, false, 'https://i.imgur.com/W31l3cP.png', '2024-12-30 06:10:00', 9),
(90, '這款「葬送的芙莉蓮」大胸章B款以費倫為主題，紫色背景搭配細緻的花卉圖案，襯托出費倫優雅端莊的氣質。胸章上的費倫身穿經典服飾，面帶溫柔的微笑，非常適合作為隨身配件或收藏，展現角色魅力！', '徽章 B款 費倫', 57, false, 'https://i.imgur.com/0IFkU5Q.png', '2024-12-30 06:20:00', 9),
(90, '這款「葬送的芙莉蓮」大胸章A款以芙莉蓮為主題，背景為柔和的粉紫色與花卉圖案，展現出她的高貴與沉穩氣質。胸章上的芙莉蓮身著白金色經典服飾，神情溫柔，細膩的設計完美捕捉了角色的精髓，非常適合喜愛芙莉蓮的粉絲收藏或搭配使用！', '徽章 A款 芙莉蓮', 43, false, 'https://i.imgur.com/4XbGeFV.png', '2024-12-30 06:30:00', 9);

INSERT INTO "own"("product_id", "tag_id") VALUES
(1, 1), (1, 8), (2, 1), (2, 8), (3, 1), (3, 8), (4, 1), (4, 8), (5, 1), (5, 8), (6, 1), (6, 8), (7, 1), (7, 8), (8, 1), (8, 9), (9, 1), (9, 9), (10, 1), (10, 9), 
(11, 1), (11, 9), (12, 1), (12, 9), (13, 1), (13, 9), (14, 1), (14, 9), (15, 1), (15, 9), (16, 1), (16, 10), (17, 1), (17, 10), (18, 1), (18, 10), (19, 1), (19, 10), (20, 1), (20, 10), 
(21, 1), (21, 10), (22, 1), (22, 10), (23, 1), (23, 10), (24, 1), (24, 10), (25, 1), (25, 10), (26, 1), (26, 10), (27, 1), (27, 11), (28, 1), (28, 11), (29, 1), (29, 11), (30, 1), (30, 11);

INSERT INTO "own"("product_id", "tag_id") VALUES
(31, 2), (31, 8), (32, 2), (32, 8), (33, 2), (33, 8), (34, 2), (34, 8), (35, 2), (35, 8), (36, 2), (36, 11), (37, 2), (37, 11), (38, 2), (38, 11), (39, 2), (39, 11), (40, 2), (40, 10), 
(41, 2), (41, 10), (42, 2), (42, 10), (43, 2), (43, 10), (44, 2), (44, 10), (45, 2), (45, 10), (46, 2), (46, 10), (47, 2), (47, 10), (48, 2), (48, 12), (49, 2), (49, 12), (50, 2), (50, 12), 
(51, 2), (51, 12);

INSERT INTO "own"("product_id", "tag_id") VALUES
(52, 3), (52, 8), (53, 3), (53, 8), (54, 3), (54, 13), (55, 3), (55, 13), (56, 3), (56, 13), (57, 3), (57, 13), (58, 3), (58, 11), (59, 3), (59, 11), (60, 3), (60, 14), 
(61, 3), (61, 14);

INSERT INTO "own"("product_id", "tag_id") VALUES
(62, 4), (62, 8), (63, 4), (63, 8), (64, 4), (64, 14), (65, 4), (65, 12), (66, 4), (66, 8), (67, 4), (67, 11), (68, 4), (68, 11), (69, 4), (69, 13), (70, 4), (70, 8), 
(71, 4), (71, 8), (72, 4), (72, 8), (73, 4), (73, 8), (74, 4), (74, 8), (75, 4), (75, 8), (76, 4), (76, 8);

INSERT INTO "own"("product_id", "tag_id") VALUES
(77, 5), (77, 15), (78, 5), (78, 12), (79, 5), (79, 10), (80, 5), (80, 12), 
(81, 5), (81, 12), (82, 5), (82, 11), (83, 5), (83, 11), (84, 5), (84, 10), (85, 5), (85, 10), (86, 5), (86, 10), (87, 5), (87, 10), (88, 5), (88, 10), (89, 5), (89, 10), (90, 5), (90, 10), 
(91, 5), (91, 10);

INSERT INTO "own"("product_id", "tag_id") VALUES
(92, 6), (92, 8), (93, 6), (93, 8), (94, 6), (94, 8), (95, 6), (95, 8), (96, 6), (96, 10), (97, 6), (97, 10), (98, 6), (98, 16), (99, 6), (99, 9), (100, 6), (100, 16), 
(101, 6), (101, 13), (102, 6), (102, 14), (103, 6), (103, 14), (104, 6), (104, 13), (105, 6), (105, 11), (106, 6), (106, 11), (107, 6), (107, 12);

INSERT INTO "own"("product_id", "tag_id") VALUES
(108, 7), (108, 8), (109, 7), (109, 8), (110, 7), (110, 8), (111, 7), (111, 8), (112, 7), (112, 8), (113, 7), (113, 8), (114, 7), (114, 8), (115, 7), (115, 8), (116, 7), (116, 8), (117, 7), (117, 8), (118, 7), (118, 9), (119, 7), (119, 9);
