import re
import sys
from datetime import datetime, timedelta


def to_dt(time_str):
    return datetime.strptime(time_str, "%H:%M")


def format_ampm_compact(dt_obj):
    return dt_obj.strftime("%I:%M%p").lower()


def convert_schedule_from_file(filepath):
    with open(filepath, "r") as f:
        raw_schedule_text = f.read()

    lines = raw_schedule_text.strip().splitlines()
    final_entries = []

    current_time_range = ("00:00", "00:00")
    current_category = ""
    last_task_time = None
    buffered_tasks = []
    pending_block = False

    for idx, line in enumerate(lines):
        header_match = re.match(
            r"(\d{1,2}:\d{2})\s*-\s*(\d{1,2}:\d{2})\s*/\s*(.+)", line
        )
        main_task_match = re.match(r"^\s*- \[ \] (\d+)m - (.+)", line)
        subtask_match = re.match(r"^\s{4,}- \[ \] (.+)", line)

        if header_match:
            if pending_block:
                prev_start, prev_end = current_time_range
                final_entries.append(
                    f"{format_ampm_compact(prev_start)} - {format_ampm_compact(prev_end)} - {
                        current_category} - {current_category}"
                )
            start_time = to_dt(header_match.group(1))
            end_time = to_dt(header_match.group(2))
            current_category = header_match.group(3).strip()
            current_time_range = (start_time, end_time)
            last_task_time = start_time
            buffered_tasks = []
            pending_block = True

        elif main_task_match:
            duration = int(main_task_match.group(1))
            task = main_task_match.group(2).strip()
            task_start = last_task_time
            task_end = task_start + timedelta(minutes=duration)
            final_entries.append(
                f"{format_ampm_compact(
                    task_start)} - {format_ampm_compact(task_end)} - {current_category} - {task}"
            )
            last_task_time = task_end
            buffered_tasks.append(task)
            pending_block = False

        elif subtask_match:
            continue

    if pending_block:
        start, end = current_time_range
        final_entries.append(
            f"{format_ampm_compact(
                start)} - {format_ampm_compact(end)} - {current_category} - [block]"
        )

    return final_entries


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python convert_schedule.py path/to/schedule.txt")
        sys.exit(1)

    input_file = sys.argv[1]
    schedule_lines = convert_schedule_from_file(input_file)

    for line in schedule_lines:
        print(line)
