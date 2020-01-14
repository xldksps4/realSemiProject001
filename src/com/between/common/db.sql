


--회원정보 테이블
--회원정보 회원아이디 비밀번호 이름 성별 나의애칭 생년월일 이메일 탈퇴여부 등급 탈퇴날짜 가입날짜 신고횟수 커플그룹번호 앨범경로 앨범제목
CREATE TABLE TB_USER(
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

CREATE SEQUENCE TB_USER_SEQ
--DROP SEQUENCE TB_USER_SEQ;

ALTER TABLE TB_USER
    ADD CONSTRAINT FK_TB_USER_GROUP_NUM_TB_GROUP_ FOREIGN KEY (GROUP_NUM)
        REFERENCES TB_GROUP (GROUP_NUM)
        
        
--커플 일정 달력 테이블
--일정번호 커플그룹번호 일정제목  일정내용 일정시간 작성일자
CREATE TABLE TB_CAL(
    CAL_NUM        NUMBER           NOT NULL, 
    GROUP_NUM      NUMBER           NOT NULL, 
    CAL_TITLE      VARCHAR2(100)    NOT NULL, 
    CAL_CONTENT    VARCHAR2(100)    NOT NULL, 
    CAL_TIME       VARCHAR2(20)     NOT NULL, 
    CAL_DATE       DATE             NOT NULL, 
    CONSTRAINT TB_CAL_PK PRIMARY KEY (CAL_NUM)
)

CREATE SEQUENCE TB_CAL_SEQ

ALTER TABLE TB_CAL
    ADD CONSTRAINT FK_TB_CAL_GROUP_NUM_TB_GROUP_G FOREIGN KEY (GROUP_NUM)
        REFERENCES TB_GROUP (GROUP_NUM)
        
        
--커플그룹 테이블
--커플그룹번호 파트너아이디 내아이디
CREATE TABLE TB_GROUP(
    GROUP_NUM     NUMBER           NOT NULL, 
    PARTNER_ID    VARCHAR2(100)    NOT NULL, 
    USER_ID       VARCHAR2(100)    NOT NULL, 
    CONSTRAINT TB_GROUP_PK PRIMARY KEY (GROUP_NUM)
)

CREATE SEQUENCE TB_GROUP_SEQ


--결제내역 테이블
--회원아이디 보유티켓 사용티켓 결제내역
CREATE TABLE TB_PAYMENT(
    USER_ID       VARCHAR2(100)    NOT NULL, 
    PM_TICKET     NUMBER           NULL, 
    PM_USED       NUMBER           NULL, 
    PM_HISTORY    NUMBER           NULL, 
    CONSTRAINT TB_PAYMENT_PK PRIMARY KEY (USER_ID)
)

ALTER TABLE TB_PAYMENT
    ADD CONSTRAINT FK_TB_PAYMENT_USER_ID_TB_USER_ FOREIGN KEY (USER_ID)
        REFERENCES TB_USER (USER_ID)
 
        
--상담사페이지
--회원아이디(상담사) 인출티켓개수 보유티켓개수 내담자관리번호 상담진행여부 상담목적 일정관리 요일 시간 평가점수
CREATE TABLE TB_ COUNSELOR(
    USER_ID                     VARCHAR2(100)     NOT NULL,
    COUNSELOR_TICKET_USED       NUMBER            NULL, 
    COUNSELOR_TICKET            NUMBER            NULL,
    CLIENT_NUM                  NUMBER            NULL,
    COUNSELOR_PROGRESS_CHECK    VARCHAR2(20)      NULL, 
    COUNSELOR_PURPOSE           VARCHAR2(1000)    NULL,
    COUNSELOR_SCHEDULE          VARCHAR2(20)      NULL, 
    COUNSELOR_DAY               VARCHAR2(10)      NULL, 
    COUNSELOR_TIME              VARCHAR2(20)      NULL, 
    COUNSELOR_SCORE             NUMBER            NULL, 
    CONSTRAINT TB_ COUNSELOR_PK PRIMARY KEY (USER_ID)
)

CREATE SEQUENCE TB_ COUNSELOR_SEQ

ALTER TABLE TB_ COUNSELOR
    ADD CONSTRAINT FK_TB_ COUNSELOR_CLIENT_NUM_TB FOREIGN KEY (CLIENT_NUM)
        REFERENCES TB_CLIENT_MANAGEMENT (CLIENT_NUM)

ALTER TABLE TB_ COUNSELOR
    ADD CONSTRAINT FK_TB_ COUNSELOR_USER_ID_TB_US FOREIGN KEY (USER_ID)
        REFERENCES TB_USER (USER_ID)
        
--내담자관리테이블
--내담자관리번호 커플그룹번호 회원아이디
CREATE TABLE TB_CLIENT_MANAGEMENT(
    CLIENT_NUM    NUMBER           NOT NULL, 
    GROUP_NUM     VARCHAR2(20)     NOT NULL, 
    USER_ID       VARCHAR2(100)    NOT NULL, 
    CONSTRAINT TB_CLIENT_MANAGEMENT_PK PRIMARY KEY (CLIENT_NUM)
)

CREATE SEQUENCE TB_CLIENT_MANAGEMENT_SEQ

ALTER TABLE TB_CLIENT_MANAGEMENT
    ADD CONSTRAINT FK_TB_CLIENT_MANAGEMENT_GROUP_ FOREIGN KEY (GROUP_NUM)
        REFERENCES TB_GROUP (GROUP_NUM)

        
--연애말사전테이블
--사전글번호 회원아이디 키워드(제목) 남자어(내용2) 여자어(내용1) 신고여부 공감횟수(좋아요)
CREATE TABLE TB_DICTIONARY(
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

ALTER TABLE TB_DICTIONARY ADD CONSTRAINT TB_DICTIONARY_UN UNIQUE (DIC_KEYWORD);
--키워드에 유니크 제약조건 추가함

ALTER TABLE TB_DICTIONARY
    ADD CONSTRAINT FK_TB_DICTIONARY_USER_ID_TB_US FOREIGN KEY (USER_ID)
        REFERENCES TB_USER (USER_ID);
        

--게시판테이블
--회원아이디 글번호 그룹번호 그룹순서 글탭번호 삭제여부 글제목 글내용 조회수 작성일 글타입 신고 신고유형
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
    CONSTRAINT TB_BOARD_PK PRIMARY KEY (BOARD_NUM)
)
/

CREATE SEQUENCE TB_BOARD_SEQ;
CREATE SEQUENCE TB_BOARD_GROUP_SEQ;


ALTER TABLE TB_BOARD
    ADD CONSTRAINT FK_TB_BOARD_USER_ID_TB_USER_US FOREIGN KEY (USER_ID)
        REFERENCES TB_USER (USER_ID)
        

--댓글,대댓글 테이블
--글번호 댓글번호 작성자 내용 그룹번호 댓글탭번호 작성일 삭제여부 신고 신고유형
--**댓글번호 컬럼 추가됨
CREATE TABLE TB_RE_BOARD(
    BOARD_NUM          NUMBER          NOT NULL,
    RE_NUM             NUMBER          NOT NULL,
    WRITER             VARCHAR2(20)    NOT NULL, 
    RE_CONTENT         VARCHAR2(20)    NOT NULL, 
    RE_NUM             NUMBER          NOT NULL, 
    RE_TAB             NUMBER          NOT NULL, 
    RE_DATE            DATE            NOT NULL, 
    RE_DELETE_CHECK    VARCHAR2(4)     NOT NULL, 
    RE_FLAG            VARCHAR2(4)     NOT NULL, 
    RE_FLAG_TYPE       VARCHAR2(20)    NOT NULL
)

CREATE SEQUENCE TB_RE_BOARD_SEQ;
--**댓글번호 시퀀스 추가

ALTER TABLE TB_RE_BOARD
    ADD CONSTRAINT FK_TB_RE_BOARD_BOARD_NUM_TB_BO FOREIGN KEY (BOARD_NUM)
        REFERENCES TB_BOARD (BOARD_NUM)