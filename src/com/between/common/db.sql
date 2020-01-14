/*01. 회원정보 저장 위한 테이블*/
CREATE TABLE TB_USER
(
    USER_ID              VARCHAR2(100)     NOT NULL, 
    USER_PW              VARCHAR2(20)      NOT NULL, 
    USER_NAME            VARCHAR2(20)      NOT NULL, 
    USER_GENDER          VARCHAR2(5)       NOT NULL, 
    USER_NICK            VARCHAR2(100)     NULL, 
    USER_DOB             VARCHAR2(20)      NOT NULL, 
    USER_EMAIL           VARCHAR2(100)     NOT NULL, 
    USER_DEACT           VARCHAR2(4)       NOT NULL, 
    USER_STATUS          VARCHAR2(20)      NOT NULL, 
    USER_DEACT_DATE      DATE              NULL, 
    USER_REGDATE         DATE              NOT NULL, 
    USER_FLAGNO          NUMBER            NOT NULL, 
    GROUP_NUM            NUMBER            NULL, 
    USER_ALBUM_PATH      VARCHAR2(3000)    NULL, 
    USER_ALBUM_TITILE    VARCHAR2(1000)    NULL, 
    CONSTRAINT TB_USER_PK PRIMARY KEY (USER_ID)
)

CREATE SEQUENCE TB_USER_SEQ;

--DROP SEQUENCE TB_USER_SEQ;

COMMENT ON TABLE TB_USER IS '회원정보'
COMMENT ON COLUMN TB_USER.USER_ID IS '회원아이디'
COMMENT ON COLUMN TB_USER.USER_PW IS '비밀번호'
COMMENT ON COLUMN TB_USER.USER_NAME IS '이름'
COMMENT ON COLUMN TB_USER.USER_GENDER IS '성별'
COMMENT ON COLUMN TB_USER.USER_NICK IS '나의애칭'
COMMENT ON COLUMN TB_USER.USER_DOB IS '생년월일'
COMMENT ON COLUMN TB_USER.USER_EMAIL IS '이메일'
COMMENT ON COLUMN TB_USER.USER_DEACT IS '탈퇴여부'
COMMENT ON COLUMN TB_USER.USER_STATUS IS '등급'
COMMENT ON COLUMN TB_USER.USER_DEACT_DATE IS '탈퇴날짜'
COMMENT ON COLUMN TB_USER.USER_REGDATE IS '가입날짜'
COMMENT ON COLUMN TB_USER.USER_FLAGNO IS '신고횟수'
COMMENT ON COLUMN TB_USER.GROUP_NUM IS '커플 그룹 번호'
COMMENT ON COLUMN TB_USER.USER_ALBUM_PATH IS '앨범경로'
COMMENT ON COLUMN TB_USER.USER_ALBUM_TITILE IS '앨범제목'

ALTER TABLE TB_USER
    ADD CONSTRAINT FK_TB_USER_USER_ID_TB_BOARD_US FOREIGN KEY (USER_ID)
        REFERENCES TB_BOARD (USER_ID)
        
ALTER TABLE TB_USER
    ADD CONSTRAINT FK_TB_USER_GROUP_NUM_TB_GROUP_ FOREIGN KEY (GROUP_NUM)
        REFERENCES TB_GROUP (GROUP_NUM)

--////////////////////////////////////////////////////

/*02. 커플들  묶어주는 테이블*/
CREATE TABLE TB_GROUP
(
    GROUP_NUM     NUMBER           NOT NULL, 
    PARTNER_ID    VARCHAR2(100)    NOT NULL, 
    USER_ID       VARCHAR2(100)    NOT NULL, 
    CONSTRAINT TB_GROUP_PK PRIMARY KEY (GROUP_NUM)
)

CREATE SEQUENCE TB_GROUP_SEQ

--DROP SEQUENCE TB_GROUP_SEQ;

COMMENT ON TABLE TB_GROUP IS '커플'
COMMENT ON COLUMN TB_GROUP.GROUP_NUM IS '커플 그룹 번호'
COMMENT ON COLUMN TB_GROUP.PARTNER_ID IS '파트너아이디(직접입력)'
COMMENT ON COLUMN TB_GROUP.USER_ID IS '회원아이디'
--////////////////////////////////////////////////////

/*03. 커플들  달력 기능 위한 테이블*/
CREATE TABLE TB_CAL
(
    CAL_NUM        NUMBER           NOT NULL, 
    GROUP_NUM      NUMBER           NOT NULL, 
    CAL_TITLE      VARCHAR2(100)    NOT NULL, 
    CAL_CONTENT    VARCHAR2(100)    NOT NULL, 
    CAL_TIME       VARCHAR2(20)     NOT NULL, 
    CAL_DATE       DATE             NOT NULL, 
    CONSTRAINT TB_CAL_PK PRIMARY KEY (CAL_NUM)
)

CREATE SEQUENCE TB_CAL_SEQ

--DROP SEQUENCE TB_CAL_SEQ;
--DROP SEQUENCE TB_CAL_SEQ;

COMMENT ON TABLE TB_CAL IS '커플일정달력'
COMMENT ON COLUMN TB_CAL.CAL_NUM IS '일정번호'
COMMENT ON COLUMN TB_CAL.GROUP_NUM IS '커플 그룹 번호'
COMMENT ON COLUMN TB_CAL.CAL_TITLE IS '일정제목'
COMMENT ON COLUMN TB_CAL.CAL_CONTENT IS '일정내용'
COMMENT ON COLUMN TB_CAL.CAL_TIME IS '일정시간'
COMMENT ON COLUMN TB_CAL.CAL_DATE IS '작성일자'

ALTER TABLE TB_CAL
    ADD CONSTRAINT FK_TB_CAL_GROUP_NUM_TB_GROUP_G FOREIGN KEY (GROUP_NUM)
        REFERENCES TB_GROUP (GROUP_NUM)
        
--////////////////////////////////////////////////////

/*04. 연애말 사전 기능 위한 테이블*/
CREATE TABLE TB_DICTIONARY
(
    DIC_NUM        NUMBER            NOT NULL, 
    USER_ID        VARCHAR2(100)     NOT NULL, 
    DIC_KEYWORD    VARCHAR2(100)     NOT NULL, 
    DIC_MALE       VARCHAR2(2000)    NOT NULL, 
    DIC_FEMALE     VARCHAR2(2000)    NOT NULL, 
    DIC_FLAG       VARCHAR2(2)       NULL, 
    DIC_LIKE       NUMBER            NULL, 
    CONSTRAINT TB_DICTIONARY_PK PRIMARY KEY (DIC_NUM)
)

CREATE SEQUENCE TB_DICTIONARY_SEQ

--DROP SEQUENCE TB_DICTIONARY_SEQ;

COMMENT ON TABLE TB_DICTIONARY IS '연애말사전_니캉내캉'
COMMENT ON COLUMN TB_DICTIONARY.DIC_NUM IS '글번호'
COMMENT ON COLUMN TB_DICTIONARY.USER_ID IS '회원아이디'
COMMENT ON COLUMN TB_DICTIONARY.DIC_KEYWORD IS '키워드(제목)'
COMMENT ON COLUMN TB_DICTIONARY.DIC_MALE IS '남자어(내용2)'
COMMENT ON COLUMN TB_DICTIONARY.DIC_FEMALE IS '여자어(내용1)'
COMMENT ON COLUMN TB_DICTIONARY.DIC_FLAG IS '신고여부'
COMMENT ON COLUMN TB_DICTIONARY.DIC_LIKE IS '공감횟수(좋아요)'

ALTER TABLE TB_DICTIONARY
    ADD CONSTRAINT FK_TB_DICTIONARY_USER_ID_TB_US FOREIGN KEY (USER_ID)
        REFERENCES TB_USER (USER_ID)
        
--////////////////////////////////////////////////////

/*05. 게시판, 답글 기능 위한 테이블*/
CREATE TABLE TB_BOARD
(
    USER_ID               VARCHAR2(100)     NOT NULL, 
    BOARD_NUM             NUMBER            NOT NULL, 
    BOARD_GROUP_NUM       NUMBER            NOT NULL, 
    BOARD_GROUP_ORDER     NUMBER            NOT NULL, 
    BOARD_TAB             NUMBER            NOT NULL, 
    BOARD_DELETE_CHECK    CHAR(1)           NOT NULL, 
    BOARD_TITLE           VARCHAR2(20)      NOT NULL, 
    BOARD_CONTENT         VARCHAR2(4000)    NOT NULL, 
    BOARD_VIEW_COUNT      VARCHAR2(20)      NOT NULL, 
    BOARD_DATE            DATE              NOT NULL, 
    BOARD_TYPE            VARCHAR2(10)      NOT NULL, 
    BOARD_FLAG            VARCHAR2(4)       NOT NULL, 
    BOARD_FLAG_TYPE       VARCHAR2(20)      NOT NULL, 
    CONSTRAINT TB_BOARD_PK PRIMARY KEY (USER_ID)
)

CREATE SEQUENCE TB_BOARD_SEQ

CREATE SEQUENCE TB_BOARD_GROUP_SEQ


--DROP SEQUENCE TB_BOARD_SEQ;

--DROP SEQUENCE TB_BOARD_SEQ;

COMMENT ON TABLE TB_BOARD IS '게시판,답글'
COMMENT ON COLUMN TB_BOARD.USER_ID IS '회원아이디'
COMMENT ON COLUMN TB_BOARD.BOARD_NUM IS '글번호'
COMMENT ON COLUMN TB_BOARD.BOARD_GROUP_NUM IS '그룹번호'
COMMENT ON COLUMN TB_BOARD.BOARD_GROUP_ORDER IS '그룹순서'
COMMENT ON COLUMN TB_BOARD.BOARD_TAB IS '글탭번호'
COMMENT ON COLUMN TB_BOARD.BOARD_DELETE_CHECK IS '삭제여부'
COMMENT ON COLUMN TB_BOARD.BOARD_TITLE IS '글제목'
COMMENT ON COLUMN TB_BOARD.BOARD_CONTENT IS '글내용'
COMMENT ON COLUMN TB_BOARD.BOARD_VIEW_COUNT IS '조회수'
COMMENT ON COLUMN TB_BOARD.BOARD_DATE IS '작성일'
COMMENT ON COLUMN TB_BOARD.BOARD_TYPE IS '글타입(공지_일반글)'
COMMENT ON COLUMN TB_BOARD.BOARD_FLAG IS '신고'
COMMENT ON COLUMN TB_BOARD.BOARD_FLAG_TYPE IS '신고유형'

ALTER TABLE TB_BOARD
    ADD CONSTRAINT FK_TB_BOARD_BOARD_NUM_TB_RE_BO FOREIGN KEY (BOARD_NUM)
        REFERENCES TB_RE_BOARD (BOARD_NUM)
        
--////////////////////////////////////////////////////
/*06. 댓글게시판 기능 위한 테이블*/

CREATE TABLE TB_RE_BOARD
(
    BOARD_NUM          NUMBER          NOT NULL, 
    WRITER             VARCHAR2(20)    NOT NULL, 
    RE_CONTENT         VARCHAR2(20)    NOT NULL, 
    RE_NUM             NUMBER          NOT NULL, 
    RE_TAB             NUMBER          NOT NULL, 
    RE_DATE            DATE            NOT NULL, 
    RE_DELETE_CHECK    VARCHAR2(4)     NOT NULL, 
    RE_FLAG            VARCHAR2(4)     NOT NULL, 
    RE_FLAG_TYPE       VARCHAR2(20)    NOT NULL, 
    CONSTRAINT TB_RE_BOARD_PK PRIMARY KEY (BOARD_NUM)
)

CREATE SEQUENCE TB_RE_BOARD_SEQ


--DROP SEQUENCE TB_RE_BOARD_SEQ;

COMMENT ON TABLE TB_RE_BOARD IS '댓글 게시판'
COMMENT ON COLUMN TB_RE_BOARD.BOARD_NUM IS '글번호'
COMMENT ON COLUMN TB_RE_BOARD.WRITER IS '작성자'
COMMENT ON COLUMN TB_RE_BOARD.RE_CONTENT IS '댓글내용'
COMMENT ON COLUMN TB_RE_BOARD.RE_NUM IS '그룹번호'
COMMENT ON COLUMN TB_RE_BOARD.RE_TAB IS '댓글탭번호'
COMMENT ON COLUMN TB_RE_BOARD.RE_DATE IS '작성일'
COMMENT ON COLUMN TB_RE_BOARD.RE_DELETE_CHECK IS '삭제여부'
COMMENT ON COLUMN TB_RE_BOARD.RE_FLAG IS '신고'
COMMENT ON COLUMN TB_RE_BOARD.RE_FLAG_TYPE IS '신고유형'
--////////////////////////////////////////////////////

/*07. 결제 기능 위한 테이블*/

CREATE TABLE TB_PAYMENT
(
    USER_ID       VARCHAR2(100)    NOT NULL, 
    PM_TICKET     NUMBER           NULL, 
    PM_USED       NUMBER           NULL, 
    PM_HISTORY    NUMBER           NULL, 
    CONSTRAINT TB_PAYMENT_PK PRIMARY KEY (USER_ID)
)

COMMENT ON TABLE TB_PAYMENT IS '결제내역'
COMMENT ON COLUMN TB_PAYMENT.USER_ID IS '회원아이디'
COMMENT ON COLUMN TB_PAYMENT.PM_TICKET IS '보유티켓개수'
COMMENT ON COLUMN TB_PAYMENT.PM_USED IS '사용한티켓개수'
COMMENT ON COLUMN TB_PAYMENT.PM_HISTORY IS '결제내역'

ALTER TABLE TB_PAYMENT
    ADD CONSTRAINT FK_TB_PAYMENT_USER_ID_TB_USER_ FOREIGN KEY (USER_ID)
        REFERENCES TB_USER (USER_ID)
        
--////////////////////////////////////////////////////

/*08. 상담사 기능 위한 테이블*/

CREATE TABLE TB_COUNSELOR
(
    USER_ID                     VARCHAR2(100)     NOT NULL, 
    COUNSELOR_PROGRESS_CHECK    VARCHAR2(20)      NULL, 
    COUNSELOR_PURPOSE           VARCHAR2(1000)    NULL, 
    COUNSELOR_TICKET_USED       NUMBER            NULL, 
    COUNSELOR_TICKET            NUMBER            NULL, 
    COUNSELOR_SCHEDULE          VARCHAR2(20)      NULL, 
    COUNSELOR_DAY               VARCHAR2(10)      NULL, 
    COUNSELOR_TIME              VARCHAR2(20)      NULL, 
    COUNSELOR_SCORE             NUMBER            NULL, 
    CLIENT_NUM                  NUMBER            NULL, 
    CONSTRAINT TB_COUNSELOR_PK PRIMARY KEY (USER_ID)
)

CREATE SEQUENCE TB_COUNSELOR_SEQ

--DROP SEQUENCE TB_ COUNSELOR_SEQ;

COMMENT ON TABLE TB_ COUNSELOR IS '상담사 페이지'
COMMENT ON COLUMN TB_ COUNSELOR.USER_ID IS '회원아이디(상담사)'
COMMENT ON COLUMN TB_ COUNSELOR.COUNSELOR_PROGRESS_CHECK IS '상담진행여부'
COMMENT ON COLUMN TB_ COUNSELOR.COUNSELOR_PURPOSE IS '상담목적'
COMMENT ON COLUMN TB_ COUNSELOR.COUNSELOR_TICKET_USED IS '인출티켓개수'
COMMENT ON COLUMN TB_ COUNSELOR.COUNSELOR_TICKET IS '보유티켓개수'
COMMENT ON COLUMN TB_ COUNSELOR.COUNSELOR_SCHEDULE IS '일정관리'
COMMENT ON COLUMN TB_ COUNSELOR.COUNSELOR_DAY IS '요일'
COMMENT ON COLUMN TB_ COUNSELOR.COUNSELOR_TIME IS '시간'
COMMENT ON COLUMN TB_ COUNSELOR.COUNSELOR_SCORE IS '평가점수'
COMMENT ON COLUMN TB_ COUNSELOR.CLIENT_NUM IS '내담자관리번호'

ALTER TABLE TB_COUNSELOR
    ADD CONSTRAINT FK_TB_COUNSELOR_USER_ID_TB_US FOREIGN KEY (USER_ID)
        REFERENCES TB_USER (USER_ID)
        
ALTER TABLE TB_COUNSELOR
    ADD CONSTRAINT FK_TB_COUNSELOR_CLIENT_NUM_TB FOREIGN KEY (CLIENT_NUM)
        REFERENCES TB_CLIENT_MANAGEMENT (CLIENT_NUM)
        
--  ALTER TABLE TB_COUNSELOR DROP CONSTRAINT FK_TB_COUNSELOR_CLIENT_NUM_TB;

        
--////////////////////////////////////////////////////

/*09. 내담자 관리(개인,커플) 위한 테이블*/

CREATE TABLE TB_CLIENT_MANAGEMENT
(
    CLIENT_NUM    NUMBER           NOT NULL, 
    GROUP_NUM     NUMBER     NOT NULL, 
    USER_ID       VARCHAR2(100)    NOT NULL, 
    CONSTRAINT TB_CLIENT_MANAGEMENT_PK PRIMARY KEY (CLIENT_NUM)
)

DROP TABLE TB_CLIENT_MANAGEMENT


CREATE SEQUENCE TB_CLIENT_MANAGEMENT_SEQ

--DROP SEQUENCE TB_CLIENT_MANAGEMENT_SEQ;

COMMENT ON TABLE TB_CLIENT_MANAGEMENT IS '내담자관리'
COMMENT ON COLUMN TB_CLIENT_MANAGEMENT.CLIENT_NUM IS '내담자관리번호'
COMMENT ON COLUMN TB_CLIENT_MANAGEMENT.GROUP_NUM IS '커플 그룹 번호'
COMMENT ON COLUMN TB_CLIENT_MANAGEMENT.USER_ID IS '회원아이디'

ALTER TABLE TB_CLIENT_MANAGEMENT
    ADD CONSTRAINT FK_TB_CLIENT_MANAGEMENT_GROUP FOREIGN KEY (GROUP_NUM)
        REFERENCES TB_GROUP (GROUP_NUM)
        
        