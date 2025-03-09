import spotipy
from spotipy.oauth2 import SpotifyClientCredentials
import re
import os
import subprocess

CREDENTIALS_FILE = "credential.cdi"

def get_credentials():
    if os.path.exists(CREDENTIALS_FILE):
        with open(CREDENTIALS_FILE, "r", encoding="utf-8") as file:
            lines = file.readlines()
            if len(lines) >= 2:
                return lines[0].strip(), lines[1].strip()

    client_id = input("Enter your SPOTIFY_CLIENT_ID: ").strip()
    client_secret = input("Enter your SPOTIFY_CLIENT_SECRET: ").strip()

    with open(CREDENTIALS_FILE, "w", encoding="utf-8") as file:
        file.write(f"{client_id}\n{client_secret}")

    return client_id, client_secret

SPOTIFY_CLIENT_ID, SPOTIFY_CLIENT_SECRET = get_credentials()

sp = spotipy.Spotify(auth_manager=SpotifyClientCredentials(
    client_id=SPOTIFY_CLIENT_ID,
    client_secret=SPOTIFY_CLIENT_SECRET
))

def get_spotify_tracks(playlist_url):
    match = re.search(r"playlist/([\w\d]+)", playlist_url)
    if not match:
        print("\u26A0\uFE0F Playlist URL invalid!")
        return []

    playlist_id = match.group(1)
    playlist_info = sp.playlist(playlist_id)
    playlist_name = playlist_info['name']
    
    with open("playlistName.txt", "w", encoding="utf-8") as file:
        file.write(playlist_name)

    tracks = []
    offset = 0
    limit = 100

    while True:
        results = sp.playlist_tracks(playlist_id, offset=offset, limit=limit)
        for item in results['items']:
            track = item['track']
            name = track['name']
            artist = track['artists'][0]['name']
            tracks.append(f"{name} - {artist}")

        if len(results['items']) < limit:
            break

        offset += limit

    return tracks

def save_tracks_to_file(playlist_url):
    tracks = get_spotify_tracks(playlist_url)
    if not tracks:
        print("\u274C Playlist Not Found")
        return

    with open("songs.txt", "w", encoding="utf-8") as file:
        for song in tracks:
            file.write(f"{song}\n")
            print(song)

playlist_link = input("Your Playlist: ")
save_tracks_to_file(playlist_link)

subprocess.run(["Other\Downloader.bat"], shell=True)
subprocess.run(["Other\Convertor.bat"], shell=True)
