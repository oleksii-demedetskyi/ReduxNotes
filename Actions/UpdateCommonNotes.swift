struct NoteInfo: Codable {
    let id: String
    let text: String
}

struct UpdateCommonNotes: Action {
    let notes: [NoteInfo]
}
