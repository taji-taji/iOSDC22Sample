import PackagePlugin
import Foundation

@main
struct CountSwiftFiles: CommandPlugin {
  private let fileManager = FileManager.default

  func performCommand(context: PluginContext,
                      arguments: [String]) throws {
    let url = URL(fileURLWithPath:
      context.package.directory.string)

    guard let enumerator = fileManager
      .enumerator(at: url, includingPropertiesForKeys: [])
      else { return }

    var argExtractor = ArgumentExtractor(arguments)
    let excludePathList = argExtractor
      .extractOption(named: "exclude-paths")

    let excludedAbsolutePathList = excludePathList.map {
      context
        .package
        .directory
        .appending(subpath: $0)
        .string
    }

    let fileCount = enumerator.allObjects.filter({
      guard let file = $0 as? URL else { return false }
      let predicates = excludedAbsolutePathList.map {
        NSPredicate(format: "not SELF like %@", $0)
      }
      let predicate = NSCompoundPredicate(
        andPredicateWithSubpredicates: predicates
      )
      return file.pathExtension == "swift"
        && predicate.evaluate(with: file.path)
    }).count
    print(fileCount)
  }
}
