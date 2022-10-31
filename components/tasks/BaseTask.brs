sub init()
  m.top.functionName = "executeTask"
end sub

function executeTask() as void
  ? "Please implement function executeTask()"
end function

function createUrlTransfer(url as string, addAuth as boolean)
  urlTransfer = CreateObject("roUrlTransfer")

  urlTransfer.SetCertificatesFile("common:/certs/ca-bundle.crt")
  urlTransfer.InitClientCertificates()
  urlTransfer.RetainBodyOnError(true)

  urlTransfer.AddHeader("Content-type", "application/json")

  url = "https://uabmagic-api.vercel.app/api/" + url.replace(" ", "%20")

  if addAuth
    user_info = getSavedAuthInfo()

    if user_info <> invalid
      ' ? user_info
      queryChar = "?"

      if instr(1, url, "?")
        queryChar = "&"
      end if

      values = user_info.split(":")
      url = url + queryChar + "userId=" + values[0] + "&sid=" + values[1]
    end if
  end if

  ? url
  urlTransfer.SetUrl(url)

  return urlTransfer
end function

function get(url as string, addAuth as boolean) as object
  urlTransfer = createUrlTransfer(url, addAuth)

  ' ? "get(): " + urlTransfer.GetToString()

  return ParseJson(urlTransfer.GetToString())
end function

function getWithAuth(url as string) as object
  return get(url, true)
end function

function getSavedAuthInfo() as string
  sec = createObject("roRegistrySection", "UserData")

  userId = ""
  if sec.Exists("userId")
    userId = sec.Read("userId")
    ' ? "BaseTask userId: " + userId
  else
    return invalid
  end if

  sid = ""
  if sec.Exists("sid")
    sid = sec.Read("sid")
    ' ? "BaseTask sid: " + sid
  else
    return invalid
  end if

  return userId + ":" + sid
end function
