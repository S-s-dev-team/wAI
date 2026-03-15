# Component Rules

## Shared widgets to prefer

Use or extend reusable widgets such as:

- AppPrimaryButton
- AppChip
- AppBottomNavigation
- ChatBubble
- ChatInputBar
- MentorOptionCard
- DashboardCard

## Button rules

Primary button:

- uses accent background
- uses surface text color
- minimum height: from theme
- pill radius
- no arbitrary variant styling in screens

Secondary / outlined button:

- use theme-provided outlined style
- keep shape consistent with primary button

## Chip rules

Chips should support:

- active state
- inactive state

Rules:

- active uses accent or accent-related styles
- inactive uses neutral styles
- avoid creating multiple inconsistent chip variants

## Chat bubble rules

Chat bubbles should support:

- user message
- AI mentor message

Rules:

- user bubble: accent / stronger visual weight
- AI bubble: lighter visual weight
- left/right alignment should be consistent
- keep bubble styling reusable

## Input bar rules

Chat input bar should:

- stay visually lightweight
- support + action
- support send action
- remain reusable
- avoid embedding popup logic directly into screen layout if it can be extracted

## Mentor option card rules

MentorOptionCard should support:

- selected
- unselected

Rules:

- selected state uses accent + subtle background
- unselected state stays neutral
- card layout remains consistent across mentor pickers

## Dashboard card rules

Dashboard cards should:

- be reusable containers
- support title, subtitle, optional leading icon
- keep spacing and typography consistent
- avoid special-case styling in screen code
