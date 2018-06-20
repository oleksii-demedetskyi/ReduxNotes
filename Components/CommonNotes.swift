import Foundation

struct CommonNotes {
    let ids: [AllNotes.Id]
}

func reduce(state: CommonNotes, _ action: Action) -> CommonNotes {
    switch action {
    case let action as AddCommonNote:
        return CommonNotes(ids: state.ids + [AllNotes.Id(value: action.id)])
        
    default:
        return state
    }
}
