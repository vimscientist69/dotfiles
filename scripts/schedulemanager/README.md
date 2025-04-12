### 📦 1. Save Your Schedule

Create a plain text file (e.g., `schedule.txt`) with this format:

```text
3:00 - 3:05 / Wake-up
- [ ] 1m - Wake-up & Stretch
- [ ] 2m - Drink water
- [ ] 2m - Start computer setup

3:05 - 3:35 / Grooming
- [ ] 5m - Shower
- [ ] 3m - Brush teeth
- [ ] 5m - Get dressed

3:35 - 5:00 / Work Block
```

The format rules are:

- **Block Header:** `start - end / category`
- **Main Tasks:** `- [ ] Xmin - Task description`
- **Subtasks (optional):** Indented under a main task (ignored by the parser)

---

### 🧪 2. Run the Script

From the terminal (in your dotfiles repo):

```bash
python -m scripts.schedulemanager.main path/to/schedule.txt
```

Output example:

```text
03:00am - 03:01am - Wake-up - Wake-up & Stretch
03:01am - 03:03am - Wake-up - Drink water
03:03am - 03:05am - Wake-up - Start computer setup
03:05am - 03:10am - Grooming - Shower
03:10am - 03:13am - Grooming - Brush teeth
03:13am - 03:18am - Grooming - Get dressed
03:35am - 05:00am - Work Block - [block]
```

The `[block]` is a fallback for any time block with no specific tasks.

### 📲 3. Send to Shortcuts (Optional)

- Install a Shortcut that accepts **text input:** https://www.icloud.com/shortcuts/56a93cab590f4555933ca681d0e29a66
- Run this shortcut with the input text & it will automatically create all the alarms
