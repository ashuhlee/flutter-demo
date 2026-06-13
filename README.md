## Flutter + Supabase

A demo notes application built with Flutter and Supabase integration, showcasing real-time sync, custom theming and a polished user interface. Create, edit, and delete notes, drag to reorder, search feature, etc.

### Preview
<div align="center">
  <img height="600" alt="preview image" src="https://github.com/user-attachments/assets/3091642d-f7b2-4768-8040-323c2b4ea265" />
  &nbsp;&nbsp;&nbsp;
  <img height="600" alt="preview gif" src="https://github.com/user-attachments/assets/028ba755-5ff9-4e46-8b1f-9cb85392a8e7" />
</div>

### Requirements
 
- Flutter SDK (^3.12.1)
- A [Supabase](https://supabase.com) project with a `notes` table

### Build from Source
 
1. Clone the repo + install dependencies:
```bash
  git clone https://github.com/ashuhlee/flutter-demo
  cd todo_app
  flutter pub get
```

2. Create a `.env` file in the project root with Supabase credentials:
```
   URL=your_supabase_project_url
   PUBLISHABLE_KEY=your_supabase_publishable_key
```
 
3. Set up a Supabase `notes` table with the following columns:
   - `id` (int8, primary key, auto-increment)
   - `content` (text)
   - `created_at` (timestamptz, default `now()`)
   - `updated_at` (timestamptz, nullable)
   - `order` (int8)
  
5. Run the app:
```bash
   flutter run
```
 
### Project Structure
 
```
lib/
├── models/          # Note data model
├── services/        # Supabase database operations
├── theme/           # Colors and app theme
├── utils/           # Date formatting helpers
├── views/           # Main screen
└── widgets/         # Reusable UI components (app bar, dialogs, cards, etc.)
```
