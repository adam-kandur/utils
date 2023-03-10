#include <stdio.h>
#include <string.h>
#include <curl/curl.h>

void
fillUrl (char *url, char *token, char *chat_id, char *message)
{
  sprintf(url, "https://api.telegram.org/bot%s", token);
  sprintf(url + strlen(url), "/sendMessage?chat_id=%s", chat_id);
  sprintf(url + strlen(url), "&text=%s", message);
}

void
sendMessage (char *message)
{
  CURL *curl = curl_easy_init();

  if (curl)
	{
	  curl_easy_setopt(curl,
					   CURLOPT_URL,
					   message);

	  CURLcode res = curl_easy_perform(curl);
	  if (res != CURLE_OK)
		fprintf(stderr,
				"curl_easy_perform() failed: %s\n",
				curl_easy_strerror(res));

	  curl_easy_cleanup(curl);
	}
}
