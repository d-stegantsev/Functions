create or replace FUNCTION get_needed_curr(p_valcode IN VARCHAR2,
                                           p_date IN DATE DEFAULT SYSDATE) RETURN VARCHAR2 IS
                                
    v_json VARCHAR2(500);
    v_date VARCHAR2(15) := TO_CHAR(p_date,'YYYYMMDD');

BEGIN

    SELECT sys.get_nbu(p_url => 'https://bank.gov.ua/NBUStatService/v1/statdirectory/exchange?valcode='||p_valcode||'&date='||v_date||'&json')
    INTO v_json
    FROM dual;

RETURN v_json;

END get_needed_curr;

create or replace FUNCTION get_sum_product(p_productid IN NUMBER DEFAULT NULL) RETURN NUMBER IS

    total_value NUMBER;

BEGIN

    SELECT SUM(p.price * p.quantity)
    INTO total_value
    FROM products p
    WHERE (p.productid = p_productid OR p_productid IS NULL);

    RETURN total_value;

END;
