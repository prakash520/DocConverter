# DocConverter

## Overview
DocConverter is a simple document management app for iOS. It allows users to:
- Create and save documents with images.
- View, edit, and delete documents.
- Generate PDF files from saved images.
- Share documents as PDFs.

---

## Features

### **Home Screen**
- **Grid Layout**: Displays documents in a two-column grid.
- **Add Button**: Provides a custom tab with a floating **Add** button for creating new documents.
- **Navigation**: Navigate to a detailed view of the document on tap.

### **Document View**
- Add images to a document.
- Generate PDF from the document images.
- Save and share the document.

### **Core Data Integration**
- Documents and their images are saved locally using Core Data.
- Images are fetched dynamically for each document.

---

## How It Works

### **HomeView**
- Displays a grid of documents fetched from `CoreDataManager`.
- Uses a custom **Add** button to add new documents.
- Implements `NavigationLink` for navigating to the `DocumentView`.

### **CoreDataManager**
Manages the Core Data stack and provides methods for:
- Saving documents with images.
- Fetching all documents and their associated images.
- Deleting documents.

