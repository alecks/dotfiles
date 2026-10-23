"""Waybar date label with an English ordinal day."""
from datetime import datetime


def ordinal(day):
    suffix = "th" if 11 <= day % 100 <= 13 else {1: "st", 2: "nd", 3: "rd"}.get(day % 10, "th")
    return f"{day}{suffix}"


if __name__ == "__main__":
    now = datetime.now()
    print(f"{now:%A} {ordinal(now.day)}")
