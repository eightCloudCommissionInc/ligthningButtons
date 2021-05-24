@isTest
global class ExampleCalloutMock implements HttpCalloutMock{
    global HttpResponse respond(HTTPRequest req){
        HttpResponse res = new HttpResponse();
        res.setStatus('OK');
        res.setStatusCode(200);
      string b='{"acces_token": "roNkkUAKqjSXGAwELUzG0jJqsOzH","organizer_key": "4020361335943063046"}';

        res.setBody(b);
        return res;
    }
}