#!/usr/bin/python3
import lirc
import sys
import telnetlib
import json
import threading
import time


# Init

server   = "raspi3"
clientid = "000000001aa2b9be"

sockid = lirc.init("snapcast",verbose=True)
flag=True

telnet = telnetlib.Telnet(server, 1705)
requestId = 1

# Funktionen

def doRequest( j, requestId ):
#  print("send: " + j)

  telnet.write(j.encode('ascii') + b"\r\n")
  while (True):
    response = telnet.read_until(b"\r\n", 2).decode()
    jResponse = json.loads(response)
    if 'id' in jResponse:
      if jResponse['id'] == requestId:
        # print("recv: " + response)
        return jResponse;
  return;

def setVolume(client, volume,mute):
  global requestId
  doRequest(json.dumps({'jsonrpc': '2.0', 'method': 'Client.SetVolume', 'params': {'id':  client, 'volume': {'muted': mute, 'percent': volume }}, 'id': requestId}), requestId)
  requestId = requestId + 1


def getvolume():
  j = doRequest(json.dumps({'jsonrpc': '2.0', 'method': 'Client.GetStatus', 'params':{'id': clientid}, 'id': 1}), 1)
  return int(j['result']['client']['config']['volume']['percent'])

def getmute():
  j = doRequest(json.dumps({'jsonrpc': '2.0', 'method': 'Client.GetStatus', 'params':{'id': clientid}, 'id': 1}), 1)
  return bool(j['result']['client']['config']['volume']['muted'])

while True:
  IRCode = lirc.nextcode()
  if IRCode != []:
    if IRCode[0] == "VOL_UP":
      volume = getvolume() + 1
      if volume<=100:
        setVolume(clientid, volume,False)
        print("Volume: ",volume)
    if IRCode[0] == "VOL_DOWN":
      volume = getvolume() - 1
      if volume >=0:
        setVolume(clientid, volume,False)
        print("Volume: ",volume)
    if IRCode[0] == "VOL_MUTE":
        mute = not getmute()
        volume = getvolume()
        setVolume(clientid, volume, mute)
        print("Mute  : ",mute)
telnet.close





