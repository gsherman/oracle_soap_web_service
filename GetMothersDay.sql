CREATE OR REPLACE PROCEDURE SA.get_mothers_day (
   p_year          		 number,
   p_mothersday  OUT   VARCHAR2
)
IS  
  l_request   soap_api.t_request;
  l_response  soap_api.t_response;
  l_url          VARCHAR2(32767);
  l_namespace    VARCHAR2(32767);
  l_method       VARCHAR2(32767);
  l_soap_action  VARCHAR2(32767);
  l_result_name  VARCHAR2(32767);
BEGIN
  l_url         := 'http://www.27seconds.com/Holidays/US/Dates/USHolidayDates.asmx';
  l_namespace   := 'xmlns="http://www.27seconds.com/Holidays/US/Dates/"';
  l_method      := 'GetMothersDay';
  l_soap_action := 'http://www.27seconds.com/Holidays/US/Dates/GetMothersDay';
  l_result_name := 'GetMothersDayResult'; 

  l_request := soap_api.new_request(p_method       => l_method,
                                    p_namespace    => l_namespace);
  soap_api.add_parameter(p_request => l_request,
                         p_name    => 'year',
                         p_type    => 'int',
                         p_value   =>  p_year);
  l_response := soap_api.invoke(p_request => l_request,
                                p_url     => l_url,
                                p_action  => l_soap_action);
  p_mothersday := soap_api.get_return_value(p_response  => l_response,
                                        p_name      => l_result_name,
                                        p_namespace => l_namespace);                                          
END get_mothers_day;
.
/
SHOW ERRORS PROCEDURE get_mothers_day

--dependent on http://www.oracle-base.com/dba/miscellaneous/soap_api.sql

--SQL> var t_out varchar2(100);
--SQL> exec get_mothers_day('2011',:t_out);
--SQL> print t_out;
