import Foundation

struct CommonNotes {
    let ids: [AllNotes.Id]
}

func reduce(state: CommonNotes, _ action: Action) -> CommonNotes {
    switch action {
    case let action as AddCommonNote:
        return CommonNotes(ids: state.ids + [AllNotes.Id(value: action.id)])
        
    case let action as UpdateCommonNotes:
        return CommonNotes(ids: action.notes.map { AllNotes.Id(value: $0.id) })
        
    default:
        return state
    }
}
